import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../shared/logger/log.dart';
import 'i_remote_config.dart';

class RemoteConfigService implements IRemoteConfigService {
  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;

  final FirebaseRemoteConfig _remoteConfig;

  @override
  Future<void> initialize() async {
    try {
      await _setDefaults();
      await _setConfigSettings();
      await _activate();
      _fetch();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  void _fetch() async {
    try {
      await _remoteConfig.fetch();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  Future<void> _setConfigSettings() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  Future<void> _activate() async {
    await _remoteConfig.activate();
  }

  Future<void> _setDefaults() async {
    await _remoteConfig.setDefaults({
      'feature_login_offline': false,
    });
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }
}
