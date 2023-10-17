import '../../../../core/remoteconfig/i_remote_config.dart';

class LoginOfflineToggleFeature {
  LoginOfflineToggleFeature({
    required IRemoteConfigService remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfigService _remoteConfig;
  static const String featureToggle = 'feature_login_offline';

  bool get isEnabled => _isEnabled();

  bool _isEnabled() {
    try {
      return _remoteConfig.getBool(featureToggle);
    } catch (_) {
      return false;
    }
  }
}
