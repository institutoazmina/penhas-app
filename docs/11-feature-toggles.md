# Feature Toggles

## Visão Geral

Feature toggles (ou feature flags) são uma técnica poderosa que permite ativar ou desativar funcionalidades do aplicativo remotamente, sem necessidade de nova publicação nas lojas. O PenhaS utiliza o Firebase Remote Config para gerenciar essas configurações.

## Por que usar Feature Toggles?

1. **Lançamento Gradual**: Liberar funcionalidades para grupos específicos
2. **Testes A/B**: Testar diferentes versões de uma funcionalidade
3. **Rollback Rápido**: Desativar funcionalidades problemáticas instantaneamente
4. **Desenvolvimento Contínuo**: Mesclar código incompleto sem afetar produção
5. **Personalização**: Adaptar a experiência por região, dispositivo ou usuário

## Configuração do Firebase Remote Config

### 1. Setup Inicial

```dart
// lib/app/core/remoteconfig/remote_config.dart

class RemoteConfigService implements IRemoteConfigService {
  const RemoteConfigService();
  
  static final _remoteConfig = FirebaseRemoteConfig.instance;
  
  Future<void> initialize() async {
    try {
      // Configurar intervalo mínimo de fetch
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1), // Produção: 1 hora
        ),
      );
      
      // Definir valores padrão
      await _remoteConfig.setDefaults(_defaultValues);
      
      // Buscar e ativar valores
      await _remoteConfig.fetchAndActivate();
      
      // Escutar mudanças em tempo real (opcional)
      _remoteConfig.onConfigUpdated.listen((event) async {
        await _remoteConfig.activate();
        _notifyListeners();
      });
      
    } catch (e) {
      logger.error('Erro ao inicializar Remote Config', e);
      // Usar valores padrão em caso de erro
    }
  }
}
```

### 2. Valores Padrão

```dart
// Valores padrão caso o Remote Config falhe
static const Map<String, dynamic> _defaultValues = {
  'feature_login_offline': false,
  'feature_chat_private': false,
  'feature_escape_manual': true,
  'feature_audio_recording_max_duration': 300, // 5 minutos
  'config_quiz_animation_duration': 400,
  'config_auto_logout_minutes': 5,
  'config_max_guardians': 5,
  'maintenance_mode': false,
  'maintenance_message': '',
  'minimum_app_version': '3.0.0',
};
```

## Implementação de Feature Toggles

### 1. Criar Feature Toggle

```dart
// lib/app/features/authentication/domain/usecases/login_offline_toggle.dart

class LoginOfflineToggleFeature {
  LoginOfflineToggleFeature({
    required IRemoteConfigService remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfigService _remoteConfig;
  
  static const String _featureKey = 'feature_login_offline';
  
  Future<bool> get isEnabled async {
    try {
      return _remoteConfig.getBool(_featureKey);
    } catch (e) {
      // Retornar valor padrão em caso de erro
      return _defaultValues[_featureKey] as bool;
    }
  }
  
  // Para desenvolvimento/testes
  @visibleForTesting
  Future<void> setEnabled(bool value) async {
    if (kDebugMode) {
      await _remoteConfig.setDefaults({_featureKey: value});
    }
  }
}
```

### 2. Usar no Código

```dart
// Em um Use Case
class AuthenticationUseCase {
  final LoginOfflineToggleFeature _loginOfflineToggle;
  
  Future<Either<Failure, Session>> authenticate() async {
    // Verificar se login offline está habilitado
    if (await _loginOfflineToggle.isEnabled) {
      return _attemptOfflineLogin();
    }
    
    return _attemptOnlineLogin();
  }
}

// Em uma Store
class LoginStore extends _LoginStoreBase with _$LoginStore {
  @observable
  bool showOfflineOption = false;
  
  @action
  Future<void> checkFeatures() async {
    showOfflineOption = await _loginOfflineToggle.isEnabled;
  }
}

// Em um Widget
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            // Campos de login padrão
            EmailField(),
            PasswordField(),
            
            // Mostrar opção offline apenas se habilitada
            if (store.showOfflineOption)
              OfflineLoginButton(),
              
            LoginButton(),
          ],
        );
      },
    );
  }
}
```

## Toggles Disponíveis no PenhaS

### Features

| Toggle | Tipo | Padrão | Descrição |
|--------|------|---------|-----------|
| `feature_login_offline` | `bool` | `false` | Habilita login offline no modo camuflado |
| `feature_chat_private` | `bool` | `false` | Habilita chat privado entre usuárias |
| `feature_escape_manual` | `bool` | `true` | Mostra/oculta manual de fuga |
| `feature_support_center_map` | `bool` | `true` | Habilita mapa de pontos de apoio |
| `feature_audio_panic_button` | `bool` | `true` | Habilita gravação no botão de pânico |
| `feature_quiz_module` | `bool` | `true` | Habilita módulo de questionários |
| `feature_feed_anonymous` | `bool` | `true` | Permite posts anônimos no feed |

### Configurações

| Toggle | Tipo | Padrão | Descrição |
|--------|------|---------|-----------|
| `config_quiz_animation_duration` | `int` | `400` | Duração das animações do quiz (ms) |
| `config_auto_logout_minutes` | `int` | `5` | Tempo para logout automático |
| `config_max_guardians` | `int` | `5` | Número máximo de guardiões |
| `config_audio_max_duration` | `int` | `300` | Duração máxima de gravação (segundos) |
| `config_feed_page_size` | `int` | `20` | Itens por página no feed |
| `config_chat_reconnect_delay` | `int` | `5000` | Delay para reconexão do chat (ms) |

### Manutenção

| Toggle | Tipo | Padrão | Descrição |
|--------|------|---------|-----------|
| `maintenance_mode` | `bool` | `false` | Ativa modo de manutenção |
| `maintenance_message` | `String` | `""` | Mensagem durante manutenção |
| `minimum_app_version` | `String` | `"3.0.0"` | Versão mínima do app |
| `force_update_message` | `String` | `""` | Mensagem para atualização forçada |

## Gerenciamento no Console

### 1. Acessar Remote Config

1. [Firebase Console](https://console.firebase.google.com)
2. Selecionar projeto PenhaS
3. Remote Config no menu lateral

### 2. Criar/Editar Parâmetros

```json
// Exemplo de parâmetro com condições
{
  "parameter_key": "feature_chat_private",
  "default_value": false,
  "conditional_values": [
    {
      "condition_name": "Beta Testers",
      "value": true
    },
    {
      "condition_name": "iOS Users",
      "value": true
    }
  ]
}
```

### 3. Condições Disponíveis

- **Plataforma**: iOS, Android
- **Versão do App**: Específica ou range
- **País/Região**: Por localização
- **Idioma**: Por configuração do dispositivo
- **Audiência**: Grupos do Analytics
- **Porcentagem**: Para rollout gradual

## Estratégias de Rollout

### 1. Rollout Gradual

```javascript
// No Firebase Console
{
  "conditions": [
    {
      "name": "10% dos usuários",
      "expression": "percent <= 10",
      "value": true
    },
    {
      "name": "50% dos usuários",
      "expression": "percent <= 50",
      "value": true
    },
    {
      "name": "Todos",
      "expression": "true",
      "value": true
    }
  ]
}
```

### 2. Beta Testing

```dart
class FeatureManager {
  // Verificar se usuário é beta tester
  Future<bool> isBetaTester() async {
    final userId = await _userStore.userId;
    final betaTesters = _remoteConfig.getStringList('beta_testers');
    
    return betaTesters.contains(userId);
  }
  
  // Habilitar features beta
  Future<Map<String, bool>> getBetaFeatures() async {
    if (!await isBetaTester()) {
      return {};
    }
    
    return {
      'chat_private': true,
      'advanced_analytics': true,
      'experimental_ui': true,
    };
  }
}
```

### 3. A/B Testing

```dart
// Configurar experimento
class ExperimentManager {
  Future<String> getExperimentVariant(String experimentName) async {
    // Remote Config retorna variante
    return _remoteConfig.getString('experiment_$experimentName');
  }
  
  // Exemplo: Testar diferentes textos de CTA
  Future<String> getLoginButtonText() async {
    final variant = await getExperimentVariant('login_cta');
    
    switch (variant) {
      case 'A':
        return 'Entrar';
      case 'B':
        return 'Acessar minha conta';
      case 'C':
        return 'Fazer login';
      default:
        return 'Entrar';
    }
  }
}
```

## Monitoramento e Analytics

### 1. Tracking de Features

```dart
class FeatureAnalytics {
  static void trackFeatureUsage(String featureName, bool isEnabled) {
    analytics.logEvent(
      'feature_toggle_checked',
      parameters: {
        'feature_name': featureName,
        'is_enabled': isEnabled,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
  
  static void trackFeatureInteraction(String featureName, String action) {
    analytics.logEvent(
      'feature_interaction',
      parameters: {
        'feature_name': featureName,
        'action': action,
        'user_segment': _getUserSegment(),
      },
    );
  }
}
```

### 2. Dashboard de Monitoramento

Métricas importantes:
- Taxa de adoção por feature
- Erros relacionados a features
- Performance por variante
- Feedback dos usuários

## Boas Práticas

### 1. Nomenclatura

```dart
// Prefixos recomendados
feature_*     // Para features completas
config_*      // Para configurações
experiment_*  // Para testes A/B
debug_*       // Para desenvolvimento
```

### 2. Documentação

```dart
/// Feature Toggle para chat privado entre usuárias
/// 
/// Quando habilitado:
/// - Adiciona aba "Pessoas" no chat
/// - Permite buscar e conversar com outras usuárias
/// - Habilita sistema de bloqueio/denúncia
/// 
/// Dependências:
/// - Requer backend v2.5+
/// - Incompatível com modo anônimo
class ChatPrivateToggleFeature {
  // ...
}
```

### 3. Fallbacks

```dart
class SafeFeatureToggle {
  Future<T> getValue<T>(
    String key,
    T defaultValue, {
    Duration? timeout,
  }) async {
    try {
      // Tentar buscar com timeout
      return await _remoteConfig
          .getValue(key)
          .timeout(timeout ?? const Duration(seconds: 3));
    } catch (e) {
      // Log erro mas não quebrar app
      logger.warning('Feature toggle fallback: $key', e);
      return defaultValue;
    }
  }
}
```

### 4. Cache Local

```dart
class CachedRemoteConfig {
  final Map<String, dynamic> _cache = {};
  DateTime? _lastFetch;
  
  Future<T> getCachedValue<T>(String key, T defaultValue) async {
    // Usar cache se fetch recente
    if (_lastFetch != null && 
        DateTime.now().difference(_lastFetch!) < Duration(minutes: 5)) {
      return _cache[key] as T? ?? defaultValue;
    }
    
    // Buscar novo valor
    try {
      await _remoteConfig.fetchAndActivate();
      _lastFetch = DateTime.now();
      _updateCache();
    } catch (e) {
      // Usar cache antigo se disponível
    }
    
    return _cache[key] as T? ?? defaultValue;
  }
}
```

## Troubleshooting

### Problema: Valores não atualizam

```dart
// Forçar fetch ignorando cache
await FirebaseRemoteConfig.instance.setConfigSettings(
  RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: Duration.zero, // Apenas para debug!
  ),
);
await FirebaseRemoteConfig.instance.fetchAndActivate();
```

### Problema: App quebra sem internet

```dart
// Sempre ter fallback local
class ResilientFeatureToggle {
  Future<bool> isEnabled(String key) async {
    try {
      // Tentar Remote Config
      return _remoteConfig.getBool(key);
    } catch (e) {
      // Fallback para SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('cached_$key') ?? _defaultValues[key];
    }
  }
}
```

## Migração de Features

### Deprecação Gradual

```dart
class DeprecatedFeature {
  Future<bool> shouldShowDeprecationWarning() async {
    final deprecationLevel = _remoteConfig.getString('feature_x_deprecation');
    
    switch (deprecationLevel) {
      case 'none':
        return false;
      case 'warning':
        return true;
      case 'disabled':
        throw FeatureDisabledException('Feature X foi descontinuada');
      default:
        return false;
    }
  }
}
```

## Próximos Passos

- Consulte [Resolução de Problemas](12-troubleshooting.md) para issues comuns
- Veja [Build e Deploy](10-build-deploy.md) para publicar com toggles
- Revise [Testes](08-testes.md) para testar feature toggles