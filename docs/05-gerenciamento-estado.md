# Gerenciamento de Estado

## Visão Geral

O aplicativo PenhaS utiliza **MobX** como solução principal para gerenciamento de estado, combinado com o padrão de **Stores** para organizar a lógica de negócio e estado da aplicação. Esta abordagem proporciona reatividade, performance e facilidade de manutenção.

## Por que MobX?

O MobX foi escolhido por várias razões:

1. **Reatividade Automática**: Atualizações de UI sem boilerplate
2. **Performance**: Apenas componentes afetados são reconstruídos
3. **Simplicidade**: Sintaxe clara e intuitiva
4. **Testabilidade**: Fácil de testar stores isoladamente
5. **Debugging**: Ferramentas excelentes para debug

## Conceitos Fundamentais

### 1. Observables

Valores que podem ser observados por mudanças:

```dart
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  String name = '';
  
  @observable
  bool isLoading = false;
  
  @observable
  ObservableList<String> permissions = ObservableList<String>();
}
```

### 2. Actions

Métodos que modificam observables:

```dart
abstract class _UserStoreBase with Store {
  @observable
  String name = '';
  
  @action
  void setName(String newName) {
    name = newName;
  }
  
  @action
  Future<void> loadUser() async {
    isLoading = true;
    try {
      final user = await repository.getUser();
      name = user.name;
    } finally {
      isLoading = false;
    }
  }
}
```

### 3. Computed Values

Valores derivados de outros observables:

```dart
abstract class _UserStoreBase with Store {
  @observable
  String firstName = '';
  
  @observable
  String lastName = '';
  
  @computed
  String get fullName => '$firstName $lastName'.trim();
  
  @computed
  bool get hasCompleteName => firstName.isNotEmpty && lastName.isNotEmpty;
}
```

### 4. Reactions

Efeitos colaterais baseados em mudanças de estado:

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<ReactionDisposer> _disposers = [];
  final store = UserStore();
  
  @override
  void initState() {
    super.initState();
    
    // Reaction simples
    _disposers.add(
      reaction(
        (_) => store.isLoggedIn,
        (isLoggedIn) {
          if (!isLoggedIn) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
    
    // AutoRun - executa sempre que observables mudam
    _disposers.add(
      autorun((_) {
        print('User name: ${store.name}');
      }),
    );
  }
  
  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }
}
```

## Padrão Store

### Estrutura Básica de uma Store

```dart
// user_profile_store.dart
import 'package:mobx/mobx.dart';
import 'package:dartz/dartz.dart';

part 'user_profile_store.g.dart';

class UserProfileStore = _UserProfileStoreBase with _$UserProfileStore;

abstract class _UserProfileStoreBase with Store {
  _UserProfileStoreBase({
    required this.repository,
    required this.localStorage,
  });

  final IUserRepository repository;
  final ILocalStorage localStorage;

  @observable
  UserProfile? profile;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get hasProfile => profile != null;

  @action
  Future<void> loadProfile() async {
    isLoading = true;
    errorMessage = null;

    final result = await repository.getUserProfile();
    
    result.fold(
      (failure) => errorMessage = failure.message,
      (userProfile) {
        profile = userProfile;
        _saveToCache(userProfile);
      },
    );

    isLoading = false;
  }

  Future<void> _saveToCache(UserProfile profile) async {
    await localStorage.save('user_profile', profile.toJson());
  }
}
```

### Integração com Flutter

Uso do `Observer` widget para reagir a mudanças:

```dart
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfilePage extends StatelessWidget {
  final UserProfileStore store;

  const UserProfilePage({required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const CircularProgressIndicator();
          }

          if (store.errorMessage != null) {
            return ErrorWidget(store.errorMessage!);
          }

          if (!store.hasProfile) {
            return const EmptyProfileWidget();
          }

          return ProfileContent(profile: store.profile!);
        },
      ),
    );
  }
}
```

## Organização de Stores

### Stores Globais

Gerenciadas pelo sistema de injeção de dependência:

```dart
// No AppModule ou módulo específico
Bind.lazySingleton<UserProfileStore>(
  (i) => UserProfileStore(
    repository: i.get(),
    localStorage: i.get(),
  ),
),
```

### Stores Locais

Para estado específico de uma tela:

```dart
class ChatChannelPage extends StatefulWidget {
  final String channelId;
  
  @override
  _ChatChannelPageState createState() => _ChatChannelPageState();
}

class _ChatChannelPageState extends State<ChatChannelPage> {
  late final ChatChannelStore store;
  
  @override
  void initState() {
    super.initState();
    store = ChatChannelStore(
      channelId: widget.channelId,
      repository: Modular.get(),
    );
    store.initialize();
  }
  
  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }
}
```

## Padrões Comuns

### 1. Estado de Loading

```dart
abstract class _BaseStoreWithLoading with Store {
  @observable
  bool isLoading = false;

  @action
  Future<T> runWithLoading<T>(Future<T> Function() operation) async {
    isLoading = true;
    try {
      return await operation();
    } finally {
      isLoading = false;
    }
  }
}
```

### 2. Tratamento de Erros

```dart
abstract class _BaseStoreWithError with Store {
  @observable
  String? errorMessage;

  @observable
  bool hasError = false;

  @action
  void setError(String message) {
    errorMessage = message;
    hasError = true;
  }

  @action
  void clearError() {
    errorMessage = null;
    hasError = false;
  }
}
```

### 3. Paginação

```dart
abstract class _PaginatedListStore<T> with Store {
  @observable
  ObservableList<T> items = ObservableList<T>();

  @observable
  bool isLoadingMore = false;

  @observable
  bool hasReachedEnd = false;

  @observable
  int currentPage = 1;

  @action
  Future<void> loadMore() async {
    if (isLoadingMore || hasReachedEnd) return;

    isLoadingMore = true;
    
    final newItems = await fetchPage(currentPage);
    
    if (newItems.isEmpty) {
      hasReachedEnd = true;
    } else {
      items.addAll(newItems);
      currentPage++;
    }
    
    isLoadingMore = false;
  }

  Future<List<T>> fetchPage(int page);
}
```

### 4. Formulários

```dart
abstract class _FormStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  ObservableMap<String, String> errors = ObservableMap();

  @computed
  bool get isValid => email.isNotEmpty && password.isNotEmpty && errors.isEmpty;

  @action
  void setEmail(String value) {
    email = value;
    _validateEmail();
  }

  @action
  void setPassword(String value) {
    password = value;
    _validatePassword();
  }

  void _validateEmail() {
    if (!EmailValidator.validate(email)) {
      errors['email'] = 'Email inválido';
    } else {
      errors.remove('email');
    }
  }

  void _validatePassword() {
    if (password.length < 6) {
      errors['password'] = 'Senha deve ter pelo menos 6 caracteres';
    } else {
      errors.remove('password');
    }
  }
}
```

## Comunicação Entre Stores

### Via Injeção de Dependência

```dart
class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  _FeedStoreBase({
    required this.userStore,
    required this.repository,
  });

  final UserStore userStore;
  final IFeedRepository repository;

  @action
  Future<void> createPost(String content) async {
    if (!userStore.isLoggedIn) {
      throw Exception('User must be logged in');
    }

    final post = await repository.createPost(
      content: content,
      userId: userStore.profile!.id,
    );
    
    // Update feed
    posts.insert(0, post);
  }
}
```

### Via Eventos/Streams

```dart
class EventBus {
  static final _streamController = StreamController<AppEvent>.broadcast();
  
  static Stream<T> on<T extends AppEvent>() {
    return _streamController.stream.whereType<T>();
  }
  
  static void fire(AppEvent event) {
    _streamController.add(event);
  }
}

// Uso em stores
abstract class _NotificationStoreBase with Store {
  _NotificationStoreBase() {
    EventBus.on<NewMessageEvent>().listen((event) {
      addNotification(event.message);
    });
  }
}
```

## Code Generation

O MobX usa code generation para criar o boilerplate:

```bash
# Gerar uma vez
fvm flutter pub run build_runner build

# Watch mode para desenvolvimento
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Testes

### Testando Stores

```dart
void main() {
  group('UserProfileStore', () {
    late UserProfileStore store;
    late MockUserRepository mockRepository;
    late MockLocalStorage mockStorage;

    setUp(() {
      mockRepository = MockUserRepository();
      mockStorage = MockLocalStorage();
      store = UserProfileStore(
        repository: mockRepository,
        localStorage: mockStorage,
      );
    });

    test('loadProfile success', () async {
      final profile = UserProfile(id: '1', name: 'Test');
      when(() => mockRepository.getUserProfile())
          .thenAnswer((_) async => Right(profile));

      await store.loadProfile();

      expect(store.profile, equals(profile));
      expect(store.isLoading, isFalse);
      expect(store.errorMessage, isNull);
    });

    test('computed values work correctly', () {
      expect(store.hasProfile, isFalse);
      
      store.profile = UserProfile(id: '1', name: 'Test');
      
      expect(store.hasProfile, isTrue);
    });
  });
}
```

## Boas Práticas

1. **Mantenha stores focadas**: Uma store por domínio/feature
2. **Use computed values**: Para valores derivados
3. **Actions assíncronas**: Sempre marque com `@action`
4. **Evite lógica na UI**: Coloque na store
5. **Dispose reactions**: Limpe reactions quando não necessárias
6. **Use ObservableList/Map**: Para coleções reativas
7. **Teste stores isoladamente**: Facilita manutenção

## Performance

### Otimizações

1. **Use `Observer` com parcimônia**: Apenas onde necessário
2. **Computed values**: São cached automaticamente
3. **Reactions específicas**: Use `when` e `reaction` ao invés de `autorun`
4. **Batch updates**: MobX agrupa mudanças automaticamente

### Debug

```dart
// Habilitar logs do MobX
import 'package:mobx/mobx.dart';

void main() {
  mainContext.config = mainContext.config.clone(
    isSpyEnabled: true,
  );
  
  runApp(MyApp());
}
```

## Próximos Passos

- Veja [Autenticação e Segurança](06-autenticacao-seguranca.md) para gerenciamento de sessão
- Explore [Integração com API](07-integracao-api.md) para sincronização de estado
- Consulte [Testes](08-testes.md) para estratégias de teste de stores