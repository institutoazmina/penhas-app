import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../shared/logger/log.dart';
import 'i_remote_config.dart';

class RemoteConfig implements IRemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Future<void> initialize() async {
    try {
      await setConfigSettings();
      await activate();
      fetch();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  void fetch() async {
    try {
      await remoteConfig.fetch();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  Future<void> setConfigSettings() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
  }

  Future<void> activate() async {
    await remoteConfig.activate();
  }

  Future<void> setDefaults() async {
    // TODO: use default templates
    await remoteConfig.setDefaults(const {
      'feature_login_offline': false,
    });
  }

  @override
  bool getBool(String key) {
    return remoteConfig.getBool(key);
  }
}
