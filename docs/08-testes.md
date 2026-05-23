# Estratégia de Testes

## Visão Geral

O aplicativo PenhaS implementa uma estratégia abrangente de testes para garantir qualidade, confiabilidade e manutenibilidade. A abordagem inclui testes unitários, de widget, de integração e golden tests.

## Tipos de Testes

### 1. Testes Unitários

Testam unidades isoladas de código como funções, classes e métodos.

```dart
// test/app/features/authentication/domain/usecases/authenticate_user_test.dart

void main() {
  group('AuthenticateUserUseCase', () {
    late AuthenticateUserUseCase useCase;
    late MockAuthenticationRepository mockRepository;
    late MockAppConfiguration mockAppConfig;
    late MockUserProfileStore mockUserStore;

    setUp(() {
      mockRepository = MockAuthenticationRepository();
      mockAppConfig = MockAppConfiguration();
      mockUserStore = MockUserProfileStore();
      
      useCase = AuthenticateUserUseCase(
        repository: mockRepository,
        appConfiguration: mockAppConfig,
        userProfileStore: mockUserStore,
      );
    });

    test('should return SessionEntity when authentication succeeds', () async {
      // Arrange
      const email = 'test@example.com';
      const password = 'Test@123';
      final expectedSession = SessionEntity(
        token: 'valid_token',
        user: UserProfile(id: '1', email: email),
      );

      when(() => mockRepository.authenticate(
        email: email,
        password: password,
      )).thenAnswer((_) async => Right(expectedSession));

      when(() => mockAppConfig.saveApiToken(token: any(named: 'token')))
          .thenAnswer((_) async => {});
      
      when(() => mockUserStore.save(any()))
          .thenAnswer((_) async => {});

      // Act
      final result = await useCase(email: email, password: password);

      // Assert
      expect(result.isRight(), isTrue);
      result.fold(
        (failure) => fail('Should not return failure'),
        (session) {
          expect(session.token, equals('valid_token'));
          expect(session.user.email, equals(email));
        },
      );

      verify(() => mockAppConfig.saveApiToken(token: 'valid_token')).called(1);
      verify(() => mockUserStore.save(expectedSession.user)).called(1);
    });

    test('should return ValidationFailure for invalid email', () async {
      // Arrange
      const invalidEmail = 'invalid-email';
      const password = 'Test@123';

      // Act
      final result = await useCase(email: invalidEmail, password: password);

      // Assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<ValidationFailure>()),
        (_) => fail('Should not return success'),
      );

      verifyNever(() => mockRepository.authenticate(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ));
    });
  });
}
```

### 2. Testes de Widget

Testam widgets individuais e sua interação.

```dart
// test/app/features/authentication/presentation/sign_in/sign_in_page_test.dart

void main() {
  group('SignInPage', () {
    late SignInController mockController;

    setUp(() {
      mockController = MockSignInController();
      when(() => mockController.isLoading).thenReturn(false);
      when(() => mockController.errorMessage).thenReturn(null);
    });

    testWidgets('should display email and password fields', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: SignInPage(controller: mockController),
        ),
      );

      // Assert
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show loading indicator when isLoading is true', 
      (tester) async {
      // Arrange
      when(() => mockController.isLoading).thenReturn(true);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: SignInPage(controller: mockController),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('should call signIn when button is pressed', (tester) async {
      // Arrange
      when(() => mockController.signIn()).thenAnswer((_) async => {});

      await tester.pumpWidget(
        MaterialApp(
          home: SignInPage(controller: mockController),
        ),
      );

      // Act
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'Test@123',
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      verify(() => mockController.signIn()).called(1);
    });
  });
}
```

### 3. Testes de Integração

Testam a integração entre múltiplos componentes.

```dart
// test/app/features/chat/integration/chat_flow_test.dart

void main() {
  group('Chat Flow Integration', () {
    late ChatChannelUseCase chatUseCase;
    late MockChatRepository mockRepository;
    late MockWebSocketService mockWebSocket;

    setUp(() {
      mockRepository = MockChatRepository();
      mockWebSocket = MockWebSocketService();
      
      chatUseCase = ChatChannelUseCase(
        repository: mockRepository,
        webSocketService: mockWebSocket,
      );
    });

    test('should load messages and connect to WebSocket', () async {
      // Arrange
      const channelId = 'channel_123';
      final messages = [
        ChatMessage(id: '1', content: 'Hello', senderId: 'user1'),
        ChatMessage(id: '2', content: 'Hi', senderId: 'user2'),
      ];

      when(() => mockRepository.getMessages(channelId))
          .thenAnswer((_) async => Right(messages));
      
      when(() => mockWebSocket.connect(channelId))
          .thenAnswer((_) async => {});

      // Act
      final stream = chatUseCase.getChannelStream(channelId);
      final events = await stream.take(2).toList();

      // Assert
      expect(events[0], isA<ChatChannelLoading>());
      expect(events[1], isA<ChatChannelLoaded>());
      
      final loadedEvent = events[1] as ChatChannelLoaded;
      expect(loadedEvent.messages, equals(messages));
      
      verify(() => mockWebSocket.connect(channelId)).called(1);
    });
  });
}
```

### 4. Golden Tests

Testam a aparência visual dos widgets.

```dart
// test/app/features/feed/presentation/golden/feed_card_golden_test.dart

void main() {
  group('FeedCard Golden Tests', () {
    setUpAll(() async {
      await loadAppFonts();
    });

    testGoldens('FeedCard appearances', (tester) async {
      final builder = GoldenBuilder.grid(
        columns: 2,
        widthToHeightRatio: 1,
      )
        ..addScenario(
          'Normal post',
          FeedCard(
            post: Post(
              id: '1',
              content: 'Este é um post de exemplo',
              author: 'Maria Silva',
              createdAt: DateTime(2024, 1, 1),
              likes: 42,
            ),
          ),
        )
        ..addScenario(
          'Post with image',
          FeedCard(
            post: Post(
              id: '2',
              content: 'Post com imagem',
              author: 'Ana Santos',
              imageUrl: 'assets/test/sample_image.png',
              createdAt: DateTime(2024, 1, 1),
              likes: 100,
            ),
          ),
        )
        ..addScenario(
          'Anonymous post',
          FeedCard(
            post: Post(
              id: '3',
              content: 'Post anônimo sobre violência',
              author: 'Anônima',
              isAnonymous: true,
              createdAt: DateTime(2024, 1, 1),
              likes: 15,
            ),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(800, 1200),
      );

      await screenMatchesGolden(tester, 'feed_card_variations');
    });
  });
}
```

## Configuração de Testes

### Flutter Test Config

```dart
// test/flutter_test_config.dart

import 'dart:async';
import 'package:alchemist/alchemist.dart';
import 'utils/test_utils.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Configurar golden tests
  await preparePageTests(testMain);
  
  // Configurar fonts para golden tests
  await loadAppFonts();
  
  // Configurar timezone para testes consistentes
  initializeTimeZones();
  
  // Executar testes
  return testMain();
}
```

### Test Utils

```dart
// test/utils/test_utils.dart

/// Configura o ambiente de teste
Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  // Configurar binding de teste
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Configurar tamanho padrão de tela
  binding.window.physicalSizeTestValue = const Size(414, 896); // iPhone 11
  binding.window.devicePixelRatioTestValue = 2.0;
  
  // Limpar após testes
  tearDown(() {
    binding.window.clearPhysicalSizeTestValue();
    binding.window.clearDevicePixelRatioTestValue();
  });
  
  await testMain();
}

/// Cria um widget testável com todas as dependências
Widget makeTestableWidget({
  required Widget child,
  List<Module>? modules,
  NavigatorObserver? navigatorObserver,
}) {
  return ModularApp(
    module: TestModule(modules: modules ?? []),
    child: MaterialApp(
      home: child,
      navigatorObservers: [
        if (navigatorObserver != null) navigatorObserver,
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
    ),
  );
}
```

## Mocks e Stubs

### Usando Mocktail

```dart
// test/utils/mocks.dart

import 'package:mocktail/mocktail.dart';

// Mock de Repository
class MockUserRepository extends Mock implements IUserRepository {}

// Mock de Use Case
class MockAuthenticateUserUseCase extends Mock 
    implements AuthenticateUserUseCase {}

// Mock de Store
class MockUserProfileStore extends Mock implements UserProfileStore {}

// Mock de API Provider
class MockApiProvider extends Mock implements IApiProvider {}

// Registrar tipos customizados
void registerFallbackValues() {
  registerFallbackValue(UserProfile.empty());
  registerFallbackValue(PaginatedRequest());
  registerFallbackValue(Uri.parse('https://example.com'));
}
```

### Factory de Dados de Teste

```dart
// test/utils/factories.dart

class TestFactory {
  static UserProfile createUser({
    String? id,
    String? email,
    String? name,
  }) {
    return UserProfile(
      id: id ?? const Uuid().v4(),
      email: email ?? faker.internet.email(),
      name: name ?? faker.person.name(),
      createdAt: DateTime.now(),
    );
  }

  static Post createPost({
    String? content,
    String? authorId,
    int? likes,
  }) {
    return Post(
      id: const Uuid().v4(),
      content: content ?? faker.lorem.sentence(),
      authorId: authorId ?? const Uuid().v4(),
      likes: likes ?? faker.randomGenerator.integer(100),
      createdAt: DateTime.now(),
    );
  }

  static ChatMessage createMessage({
    String? content,
    String? senderId,
  }) {
    return ChatMessage(
      id: const Uuid().v4(),
      content: content ?? faker.lorem.sentence(),
      senderId: senderId ?? const Uuid().v4(),
      createdAt: DateTime.now(),
    );
  }
}
```

## Testes de Store (MobX)

### Testando Stores MobX

```dart
// test/app/features/feed/presentation/feed_store_test.dart

void main() {
  group('FeedStore', () {
    late FeedStore store;
    late MockFeedRepository mockRepository;

    setUp(() {
      mockRepository = MockFeedRepository();
      store = FeedStore(repository: mockRepository);
    });

    test('initial values are correct', () {
      expect(store.posts, isEmpty);
      expect(store.isLoading, isFalse);
      expect(store.hasError, isFalse);
      expect(store.currentPage, equals(1));
    });

    test('loadPosts updates posts list', () async {
      // Arrange
      final posts = List.generate(
        5,
        (_) => TestFactory.createPost(),
      );
      
      when(() => mockRepository.getPosts(page: 1))
          .thenAnswer((_) async => Right(PaginatedResponse(
            data: posts,
            currentPage: 1,
            totalPages: 3,
            hasNext: true,
          )));

      // Act
      await store.loadPosts();

      // Assert
      expect(store.posts, equals(posts));
      expect(store.isLoading, isFalse);
      expect(store.hasError, isFalse);
      expect(store.hasMorePages, isTrue);
    });

    test('computed values work correctly', () {
      // Arrange
      store.posts = ObservableList.of([
        TestFactory.createPost(likes: 10),
        TestFactory.createPost(likes: 20),
        TestFactory.createPost(likes: 30),
      ]);

      // Assert
      expect(store.totalLikes, equals(60));
      expect(store.averageLikes, equals(20));
      expect(store.hasPosts, isTrue);
    });

    test('reactions trigger correctly', () async {
      // Arrange
      final reactions = <String>[];
      
      final disposer = reaction(
        (_) => store.posts.length,
        (length) => reactions.add('Posts count: $length'),
      );

      // Act
      store.posts.add(TestFactory.createPost());
      await Future.delayed(Duration.zero); // Aguardar reaction
      
      store.posts.add(TestFactory.createPost());
      await Future.delayed(Duration.zero);

      // Assert
      expect(reactions, equals([
        'Posts count: 1',
        'Posts count: 2',
      ]));

      // Cleanup
      disposer();
    });
  });
}
```

## Testes de API

### Mock de Respostas HTTP

```dart
// test/utils/api_mock_adapter.dart

class MockApiAdapter extends Mock implements http.Client {
  final Map<String, dynamic> _responses = {};

  void mockGet(String path, dynamic response, {int statusCode = 200}) {
    when(() => get(
      any(that: HasPath(path)),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async => http.Response(
      json.encode(response),
      statusCode,
    ));
  }

  void mockPost(
    String path,
    dynamic response, {
    int statusCode = 200,
    dynamic Function(Map<String, dynamic>)? bodyValidator,
  }) {
    when(() => post(
      any(that: HasPath(path)),
      headers: any(named: 'headers'),
      body: bodyValidator != null ? any(that: BodyValidator(bodyValidator)) : any(named: 'body'),
    )).thenAnswer((_) async => http.Response(
      json.encode(response),
      statusCode,
    ));
  }

  void mockError(String path, int statusCode, {String? message}) {
    when(() => get(
      any(that: HasPath(path)),
      headers: any(named: 'headers'),
    )).thenAnswer((_) async => http.Response(
      json.encode({'message': message ?? 'Error'}),
      statusCode,
    ));
  }
}

// Custom Matcher
class HasPath extends CustomMatcher {
  HasPath(String path) : super('Uri with path', 'path', path);

  @override
  Object? featureValueOf(actual) => (actual as Uri).path;
}
```

## Coverage e Relatórios

### Executar Testes com Coverage

```bash
# Executar todos os testes com coverage
fvm flutter test --coverage

# Executar testes específicos
fvm flutter test test/app/features/authentication --coverage

# Gerar relatório HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir relatório
open coverage/html/index.html
```

### Configuração de Coverage

```yaml
# coverage_config.yaml
include:
  - lib/**
exclude:
  - lib/**/*.g.dart
  - lib/**/*.freezed.dart
  - lib/generated/**
  - lib/l10n/**
```

## Testes de Performance

```dart
// test/performance/feed_scroll_performance_test.dart

void main() {
  group('Feed Performance', () {
    testWidgets('scrolling performance', (tester) async {
      // Arrange
      final posts = List.generate(100, (_) => TestFactory.createPost());
      
      await tester.pumpWidget(
        makeTestableWidget(
          child: FeedPage(posts: posts),
        ),
      );

      // Act & Assert
      final Stopwatch stopwatch = Stopwatch()..start();
      
      // Scroll através da lista
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -300),
        1000,
      );
      
      await tester.pumpAndSettle();
      
      stopwatch.stop();
      
      // Verificar performance
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(100), // Deve completar em menos de 100ms
      );
    });
  });
}
```

## Boas Práticas

1. **AAA Pattern**: Arrange, Act, Assert
2. **Testes isolados**: Cada teste deve ser independente
3. **Nomes descritivos**: Descreva o que está sendo testado
4. **Mock mínimo**: Mock apenas o necessário
5. **Testes determinísticos**: Evite dependências de tempo/random
6. **Coverage adequado**: Foque em qualidade, não quantidade
7. **Testes de regressão**: Adicione testes para bugs corrigidos

## CI/CD Integration

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.0.5'
    
    - name: Install dependencies
      run: flutter pub get
    
    - name: Run tests
      run: flutter test --coverage
    
    - name: Upload coverage
      uses: codecov/codecov-action@v1
      with:
        file: coverage/lcov.info
```

## Próximos Passos

- Veja [Configuração do Ambiente](09-configuracao-desenvolvimento.md) para setup de testes
- Consulte [Build e Deploy](10-build-deploy.md) para testes em CI/CD
- Revise [Resolução de Problemas](12-troubleshooting.md) para problemas comuns em testes