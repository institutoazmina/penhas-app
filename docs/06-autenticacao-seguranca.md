# Autenticação e Segurança

## Visão Geral

A segurança é um aspecto fundamental do aplicativo PenhaS, considerando a natureza sensível dos dados e a vulnerabilidade das usuárias. O sistema implementa múltiplas camadas de segurança, desde a autenticação até o armazenamento de dados.

## Fluxos de Autenticação

### 1. Login Tradicional

```dart
class AuthenticateUserUseCase {
  Future<Either<Failure, SessionEntity>> call({
    required String email,
    required String password,
  }) async {
    // Validação local
    if (!EmailValidator.validate(email)) {
      return Left(ValidationFailure('Email inválido'));
    }

    // Chamada à API
    final result = await repository.authenticate(
      email: email,
      password: password,
    );

    return result.fold(
      (failure) => Left(failure),
      (session) async {
        // Salvar token seguramente
        await appConfiguration.saveApiToken(token: session.token);
        // Salvar perfil do usuário
        await userProfileStore.save(session.user);
        return Right(session);
      },
    );
  }
}
```

### 2. Modo Camuflado (Stealth Mode)

O modo camuflado é uma funcionalidade crítica de segurança:

```dart
class AuthenticateStealthUserUseCase {
  Future<Either<Failure, SessionEntity>> call({
    required String pin,
  }) async {
    // Hash do PIN para comparação
    final hashedPin = _hashPin(pin);
    
    // Verificar PIN offline primeiro
    final storedHash = await appConfiguration.offlineHash;
    
    if (storedHash.isNotEmpty && hashedPin == storedHash) {
      // Login offline bem-sucedido
      return _offlineLogin();
    }
    
    // Tentar login online
    return _onlineStealthLogin(hashedPin);
  }
  
  String _hashPin(String pin) {
    // Usar crypt para hash seguro
    final salt = '\$2a\$10\$' + _generateSalt();
    return Crypt.sha256(pin, salt: salt).toString();
  }
}
```

#### Características do Modo Camuflado:
- Interface disfarçada de calculadora
- PIN ao invés de senha completa
- Dados separados e criptografados
- Logout automático por inatividade
- Sem rastros visíveis do app real

### 3. Login Anônimo

Para acesso rápido a recursos essenciais:

```dart
class AuthenticateAnonymousUserUseCase {
  Future<Either<Failure, SessionEntity>> call() async {
    // Gerar identificador único temporário
    final tempId = Uuid().v4();
    
    // Criar sessão anônima limitada
    final anonymousSession = SessionEntity(
      token: 'anonymous_$tempId',
      user: UserProfile.anonymous(),
      permissions: ['read_public', 'emergency_features'],
    );
    
    await appConfiguration.saveAnonymousSession(anonymousSession);
    
    return Right(anonymousSession);
  }
}
```

## Armazenamento Seguro

### 1. Flutter Secure Storage

Para dados sensíveis como tokens e credenciais:

```dart
class SecureLocalStorage implements ISecureStorage {
  static const _storage = FlutterSecureStorage();
  
  // Opções de segurança para Android
  static const _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true,
    sharedPreferencesName: 'secure_prefs',
    preferencesKeyPrefix: 'secure_',
  );
  
  // Opções de segurança para iOS
  static const _iosOptions = IOSOptions(
    accessibility: IOSAccessibility.first_unlock_this_device,
    accountName: 'penhas_secure',
  );
  
  Future<void> saveSecure(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }
  
  Future<String?> readSecure(String key) async {
    return await _storage.read(
      key: key,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }
  
  Future<void> deleteSecure(String key) async {
    await _storage.delete(
      key: key,
      aOptions: _androidOptions,
      iOptions: _iosOptions,
    );
  }
}
```

### 2. Hive com Criptografia

Para dados locais que precisam de criptografia:

```dart
class HiveCacheStorage implements ICacheStorage {
  late final HiveAesCipher _cipher;
  late final Box<dynamic> _box;
  
  Future<void> initialize() async {
    // Gerar ou recuperar chave de criptografia
    final encryptionKey = await _getOrGenerateEncryptionKey();
    
    // Criar cipher com a chave
    _cipher = HiveAesCipher(encryptionKey);
    
    // Abrir box criptografado
    _box = await Hive.openBox(
      'secure_cache',
      encryptionCipher: _cipher,
    );
  }
  
  Future<Uint8List> _getOrGenerateEncryptionKey() async {
    const keyName = 'hive_encryption_key';
    
    // Tentar recuperar chave existente
    final existingKey = await secureStorage.readSecure(keyName);
    
    if (existingKey != null) {
      return base64Decode(existingKey);
    }
    
    // Gerar nova chave
    final newKey = Hive.generateSecureKey();
    await secureStorage.saveSecure(
      keyName,
      base64Encode(newKey),
    );
    
    return newKey;
  }
}
```

## Gerenciamento de Sessão

### Token Management

```dart
class AppConfiguration implements IAppConfiguration {
  static const _tokenKey = 'br.com.penhas.tokenServer';
  static const _tokenExpiry = 'br.com.penhas.tokenExpiry';
  
  Future<bool> get isTokenValid async {
    final token = await apiToken;
    if (token.isEmpty) return false;
    
    final expiryString = await _storage.get(_tokenExpiry);
    if (expiryString == null) return false;
    
    final expiry = DateTime.parse(expiryString);
    return DateTime.now().isBefore(expiry);
  }
  
  Future<void> refreshTokenIfNeeded() async {
    if (await isTokenValid) return;
    
    // Implementar refresh token
    final result = await _authRepository.refreshToken();
    
    result.fold(
      (failure) => logout(),
      (newToken) => saveApiToken(token: newToken),
    );
  }
}
```

### Logout e Limpeza de Dados

```dart
Future<void> logout() async {
  // Parar serviços em background
  await _flutterBackgroundService.invoke('stopService');
  
  // Limpar tokens e credenciais
  await Future.wait([
    _storage.delete(_tokenKey),
    _storage.delete(_offlineHash),
    _storage.delete(_tokenExpiry),
  ]);
  
  // Limpar cache criptografado
  await _hive.deleteFromDisk();
  
  // Limpar dados do usuário
  await _clearUserData();
  
  // Navegar para login
  Modular.to.navigate('/authentication');
}
```

## Segurança de Rede

### Interceptor de Autenticação

```dart
class AuthInterceptor implements InterceptorContract {
  final IAppConfiguration appConfiguration;
  
  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    final token = await appConfiguration.apiToken;
    
    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    
    // Adicionar headers de segurança
    request.headers['X-App-Version'] = packageInfo.version;
    request.headers['X-Platform'] = Platform.operatingSystem;
    
    return request;
  }
  
  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    // Verificar se token expirou
    if (response.statusCode == 401) {
      await appConfiguration.logout();
      throw UnauthorizedException();
    }
    
    return response;
  }
}
```

### Certificate Pinning (Planejado)

```dart
class SecureHttpClient {
  static HttpClient createSecureClient() {
    final client = HttpClient();
    
    // Configurar certificate pinning
    client.badCertificateCallback = (cert, host, port) {
      // Verificar fingerprint do certificado
      final expectedFingerprint = 'SHA256:...';
      final actualFingerprint = _calculateFingerprint(cert);
      
      return actualFingerprint == expectedFingerprint;
    };
    
    return client;
  }
}
```

## Funcionalidades de Emergência

### Botão de Pânico

```dart
class PanicButtonService {
  static const _panicChannel = MethodChannel('penhas.panic');
  
  Future<void> activatePanicMode() async {
    // Ativar modo de emergência
    await _panicChannel.invokeMethod('activate');
    
    // Enviar localização para guardiões
    await _sendEmergencyAlert();
    
    // Iniciar gravação de áudio
    await _startAudioRecording();
    
    // Limpar dados sensíveis da memória
    await _clearSensitiveData();
  }
  
  Future<void> _clearSensitiveData() async {
    // Limpar mensagens do chat
    await chatStore.clearMessages();
    
    // Limpar dados temporários
    await cacheStorage.clear();
    
    // Mudar para interface camuflada
    await _switchToStealthUI();
  }
}
```

### Auto-logout por Inatividade

```dart
class InactivityLogoutUseCase {
  static const _inactivityTimeout = Duration(minutes: 5);
  Timer? _logoutTimer;
  
  void startInactivityTimer() {
    _logoutTimer?.cancel();
    
    _logoutTimer = Timer(_inactivityTimeout, () {
      if (appPreferences.autoLogoutEnabled) {
        _performAutoLogout();
      }
    });
  }
  
  void resetInactivityTimer() {
    startInactivityTimer();
  }
  
  Future<void> _performAutoLogout() async {
    // Salvar estado se necessário
    await _saveCurrentState();
    
    // Logout silencioso
    await appConfiguration.logout();
    
    // Mostrar tela de bloqueio
    Modular.to.pushReplacementNamed('/lock-screen');
  }
}
```

## Criptografia de Dados Locais

### Criptografia de Arquivos de Áudio

```dart
class AudioEncryption {
  static Future<Uint8List> encryptAudio(
    Uint8List audioData,
    String userId,
  ) async {
    // Gerar chave derivada do usuário
    final key = await _deriveKey(userId);
    
    // Gerar IV aleatório
    final iv = _generateIV();
    
    // Criptografar usando AES-256-GCM
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final encrypted = encrypter.encryptBytes(
      audioData,
      iv: iv,
    );
    
    // Retornar IV + dados criptografados
    return Uint8List.fromList([
      ...iv.bytes,
      ...encrypted.bytes,
    ]);
  }
  
  static Future<Key> _deriveKey(String userId) async {
    // Usar PBKDF2 para derivar chave
    final salt = await secureStorage.readSecure('user_salt_$userId');
    
    return Key.fromBase64(
      pbkdf2.generateKey(userId, salt, 10000, 32),
    );
  }
}
```

## Validações de Segurança

### Validação de Entrada

```dart
class SecurityValidators {
  static bool isValidPassword(String password) {
    // Mínimo 8 caracteres
    if (password.length < 8) return false;
    
    // Deve conter letra maiúscula
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    
    // Deve conter letra minúscula
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    
    // Deve conter número
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    
    // Deve conter caractere especial
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    
    return true;
  }
  
  static String sanitizeInput(String input) {
    // Remover caracteres perigosos
    return input
        .replaceAll(RegExp(r'<[^>]*>'), '') // Remove HTML
        .replaceAll(RegExp(r'[^\w\s-.]'), '') // Remove especiais
        .trim();
  }
}
```

## Boas Práticas de Segurança

1. **Nunca armazene senhas em texto claro**
2. **Use HTTPS para todas as comunicações**
3. **Implemente certificate pinning em produção**
4. **Criptografe dados sensíveis localmente**
5. **Valide todas as entradas do usuário**
6. **Implemente rate limiting**
7. **Use tokens com expiração**
8. **Limpe dados na memória após uso**
9. **Ofusque código em produção**
10. **Monitore tentativas de acesso suspeitas**

## Auditoria e Logs

```dart
class SecurityAuditLogger {
  static void logSecurityEvent(SecurityEvent event) {
    // Não logar informações sensíveis
    final sanitizedEvent = event.sanitize();
    
    // Enviar para analytics
    analytics.logEvent(
      'security_event',
      parameters: sanitizedEvent.toMap(),
    );
    
    // Salvar localmente para análise
    if (event.severity == Severity.high) {
      _saveForLaterSync(sanitizedEvent);
    }
  }
}
```

## Próximos Passos

- Veja [Integração com API](07-integracao-api.md) para segurança na comunicação
- Consulte [Testes](08-testes.md) para testes de segurança
- Revise [Resolução de Problemas](12-troubleshooting.md) para issues de segurança