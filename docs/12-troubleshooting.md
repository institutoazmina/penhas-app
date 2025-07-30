# Resolução de Problemas

## Visão Geral

Este guia aborda os problemas mais comuns encontrados durante o desenvolvimento, build e execução do aplicativo PenhaS, fornecendo soluções práticas e dicas de debugging.

## Problemas de Configuração

### Flutter/FVM

#### Erro: "Flutter SDK not found"

```bash
# Verificar instalação FVM
fvm list

# Reinstalar versão do Flutter
fvm remove 3.0.5
fvm install 3.0.5
fvm use 3.0.5 --force

# Verificar PATH
echo $PATH | grep fvm
```

#### Erro: "Dart SDK version mismatch"

```bash
# Limpar cache do Dart
fvm flutter pub cache clean

# Recriar pubspec.lock
rm pubspec.lock
fvm flutter pub get
```

### Dependências

#### Erro: "pub get failed"

```bash
# Limpar cache completo
fvm flutter clean
rm -rf .dart_tool
rm pubspec.lock

# Reinstalar dependências
fvm flutter pub get

# Se persistir, verificar proxy
export https_proxy=http://seu-proxy:porta
export http_proxy=http://seu-proxy:porta
```

#### Erro: "version solving failed"

```yaml
# Verificar conflitos no pubspec.yaml
# Usar dependency_overrides temporariamente
dependency_overrides:
  http: ^0.13.5
  collection: ^1.17.0
```

## Problemas de Build

### Android

#### Erro: "Gradle build failed"

```bash
# Limpar build Android
cd android
./gradlew clean
cd ..

# Atualizar Gradle wrapper
cd android
./gradlew wrapper --gradle-version=7.5
cd ..

# Invalidar caches
rm -rf ~/.gradle/caches
```

#### Erro: "SDK location not found"

```bash
# Criar local.properties
cd android
echo "sdk.dir=$HOME/Android/Sdk" > local.properties  # Linux
echo "sdk.dir=$HOME/Library/Android/sdk" > local.properties  # macOS
cd ..
```

#### Erro: "Duplicate class kotlin"

```gradle
// android/build.gradle
buildscript {
    ext.kotlin_version = '1.7.10' // Atualizar versão
}

// android/app/build.gradle
configurations.all {
    resolutionStrategy {
        force 'org.jetbrains.kotlin:kotlin-stdlib:1.7.10'
    }
}
```

#### Erro: Multidex

```gradle
// android/app/build.gradle
android {
    defaultConfig {
        multiDexEnabled true
    }
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

### iOS

#### Erro: "Pod install failed"

```bash
# Limpar CocoaPods
cd ios
rm -rf Pods
rm Podfile.lock
pod cache clean --all

# Reinstalar
pod install --repo-update
cd ..
```

#### Erro: "Module not found"

```bash
# Limpar build iOS
cd ios
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf build
cd ..

# Recriar projeto
fvm flutter create . --platforms=ios
```

#### Erro: "Code signing"

```bash
# Verificar certificados
security find-identity -p codesigning

# Limpar provisioning profiles
rm -rf ~/Library/MobileDevice/Provisioning\ Profiles/*

# Baixar novamente via Xcode
open ios/Runner.xcworkspace
# Xcode → Preferences → Accounts → Download Manual Profiles
```

## Problemas de Execução

### Hot Reload/Restart

#### Hot Reload não funciona

```dart
// Verificar se widgets são const
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key); // Adicionar const
  
  @override
  Widget build(BuildContext context) {
    // Evitar closures em build
    return const Text('Hello'); // Usar const quando possível
  }
}
```

#### Estado não atualiza

```dart
// Para MobX - verificar Observer
Widget build(BuildContext context) {
  return Observer( // Necessário para reatividade
    builder: (_) => Text(store.value),
  );
}

// Verificar se action foi chamada
@action
void updateValue(String newValue) {
  value = newValue; // Deve ser dentro de @action
}
```

### Performance

#### App lento/travando

```dart
// 1. Verificar logs
fvm flutter logs

// 2. Usar DevTools
fvm flutter pub global activate devtools
fvm flutter pub global run devtools

// 3. Profile mode
fvm flutter run --profile
```

#### Memória/Vazamentos

```dart
// Verificar dispose
class _MyPageState extends State<MyPage> {
  late final StreamSubscription _subscription;
  late final TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _subscription = stream.listen((_) {});
  }
  
  @override
  void dispose() {
    _subscription.cancel(); // Importante!
    _controller.dispose();
    super.dispose();
  }
}
```

## Problemas de API/Rede

### Conexão recusada

```dart
// Verificar URL base
print('API URL: ${appConfiguration.penhasServer}');

// Para localhost no emulador
// Android: usar 10.0.2.2
// iOS: usar 127.0.0.1 ou nome da máquina

// Verificar CORS (desenvolvimento)
// Backend deve permitir origem do Flutter
```

### SSL/Certificate errors

```dart
// APENAS para desenvolvimento!
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }
  runApp(MyApp());
}
```

### Timeout

```dart
// Aumentar timeout
final response = await http.get(uri).timeout(
  const Duration(seconds: 60),
  onTimeout: () {
    throw TimeoutException('Request timeout');
  },
);

// Implementar retry
Future<T> retryRequest<T>(Future<T> Function() request) async {
  int attempts = 0;
  
  while (attempts < 3) {
    try {
      return await request();
    } catch (e) {
      attempts++;
      if (attempts >= 3) rethrow;
      await Future.delayed(Duration(seconds: attempts * 2));
    }
  }
  
  throw Exception('Max retries exceeded');
}
```

## Problemas de Estado/MobX

### Reactions não disparam

```dart
// Verificar se está dentro de runApp
void main() {
  runApp(MyApp()); // MobX precisa do contexto Flutter
}

// Verificar @observable
@observable // Necessário!
String value = '';

// Verificar Observer widget
Observer(
  builder: (_) => Text(store.value), // Deve acessar observable
)
```

### "There are no observables detected"

```dart
// 1. Verificar code generation
fvm flutter pub run build_runner build

// 2. Verificar part directive
part 'my_store.g.dart'; // Necessário

// 3. Verificar classe base
class MyStore = _MyStoreBase with _$MyStore; // Padrão correto
```

## Problemas de Testes

### Testes falhando

```dart
// 1. Verificar mocks
@GenerateMocks([Repository]) // Gerar mocks
void main() {
  setUpAll(() {
    registerFallbackValue(FakeUri()); // Para argumentos
  });
}

// 2. Verificar async
test('async test', () async { // Note o async
  await tester.pumpWidget(MyWidget());
  await tester.pump(); // Aguardar frame
});

// 3. Limpar entre testes
tearDown(() {
  reset(mockRepository); // Limpar mocks
});
```

### Golden tests diferentes

```bash
# Atualizar goldens
fvm flutter test --update-goldens

# Usar font loader
setUpAll(() async {
  await loadAppFonts();
});

# Definir tamanho fixo
await tester.pumpWidgetBuilder(
  widget,
  surfaceSize: const Size(400, 800),
);
```

## Problemas de Firebase

### Configuração não encontrada

```bash
# Reconfigurar Firebase
flutterfire configure

# Verificar arquivos
# Android: android/app/google-services.json
# iOS: ios/Runner/GoogleService-Info.plist
```

### Crashlytics não reporta

```dart
// Verificar inicialização
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Necessário!
  
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  
  runApp(MyApp());
}

// Forçar crash de teste
FirebaseCrashlytics.instance.crash();
```

## Problemas de Produção

### App rejeitado na loja

#### Google Play
- Verificar permissões não utilizadas
- Remover logs de debug
- Atualizar targetSdkVersion
- Adicionar política de privacidade

#### App Store
- Verificar Info.plist permissions
- Adicionar descrições de uso
- Remover código não utilizado
- Testar em dispositivo real

### Crash em produção

```dart
// 1. Verificar Crashlytics
// 2. Adicionar mais logs
void logError(dynamic error, StackTrace? stack) {
  if (kReleaseMode) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  } else {
    print('Error: $error');
    print('Stack: $stack');
  }
}

// 3. Tratamento global
runZonedGuarded(() {
  runApp(MyApp());
}, (error, stack) {
  logError(error, stack);
});
```

## Debug Avançado

### Breakpoints não funcionam

```json
// .vscode/launch.json
{
  "configurations": [
    {
      "name": "Debug",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": ["--debug"] // Forçar modo debug
    }
  ]
}
```

### Logs detalhados

```dart
// Logger configurável
class AppLogger {
  static void log(String message, {Level level = Level.info}) {
    if (kDebugMode || level == Level.error) {
      final timestamp = DateTime.now().toIso8601String();
      print('[$timestamp] [${level.name}] $message');
    }
  }
}

// Interceptor HTTP para debug
class LoggingInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    print('→ ${request.method} ${request.url}');
    return request;
  }
}
```

### Memory profiling

```bash
# Dump de memória
fvm flutter debug dump-memory

# Análise de performance
fvm flutter analyze --performance
```

## Comandos Úteis de Emergência

```bash
# Reset completo do projeto
fvm flutter clean
rm -rf .dart_tool build .packages pubspec.lock
rm -rf ios/Pods ios/Podfile.lock
rm -rf ~/.pub-cache
fvm flutter pub get
cd ios && pod install && cd ..

# Verificar saúde do projeto
fvm flutter doctor -v
fvm flutter analyze
fvm flutter test

# Logs em tempo real
fvm flutter logs

# Rebuild específico
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Recursos Adicionais

### Documentação
- [Flutter Docs](https://docs.flutter.dev)
- [Dart Docs](https://dart.dev/guides)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

### Comunidade
- Flutter Brasil (Telegram)
- Flutter Community (Slack)
- r/FlutterDev (Reddit)

### Ferramentas
- [Dart DevTools](https://docs.flutter.dev/development/tools/devtools)
- [Flutter Inspector](https://docs.flutter.dev/development/tools/inspector)
- [Firebase Console](https://console.firebase.google.com)

## Suporte

Para problemas específicos do PenhaS:
1. Verificar issues no GitHub
2. Consultar documentação interna
3. Contatar equipe de desenvolvimento
4. Abrir novo issue com detalhes e logs