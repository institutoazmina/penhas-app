import '../../../../core/remoteconfig/i_remote_config.dart';

class LoginOfflineToggleFeature {
  LoginOfflineToggleFeature({
    required IRemoteConfigService remoteConfig,
  }) : _remoteConfig = remoteConfig;

  final IRemoteConfigService _remoteConfig;

  bool get isEnabled => _isEnabled();

  bool _isEnabled() {
    try {
      return _remoteConfig.getBool(RemoteConfigKeys.featureLoginOffline);
    } catch (_) {
      return false;
    }
  }
}
