import '../../../../core/remoteconfig/i_remote_config.dart';

class LoginOfflineToggleFeature {
  LoginOfflineToggleFeature({
    required IRemoteConfig remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfig _remoteConfig;
  static const String featureCode = 'feature_login_offline';

  bool get isEnabled => _isEnabled();

  bool _isEnabled() {
    try {
      return _remoteConfig.getBool(featureCode);
    } catch (_) {
      return false;
    }
  }
}
