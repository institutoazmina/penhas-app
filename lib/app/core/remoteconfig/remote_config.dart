import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'i_remote_config.dart';

class RemoteConfig implements IRemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Future<void> fetch() async {
    await remoteConfig.fetch();
  }

  @override
  Future<void> setConfigSettings() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  @override
  Future<void> activate() async {
    await remoteConfig.activate();
  }

  @override
  Future<void> setDefaults() async {
    await remoteConfig.setDefaults(const {
      'feature_login_offline': false,
    });
  }

  @override
  Map<String, RemoteConfigValue> getAll() {
    return remoteConfig.getAll();
  }

  @override
  RemoteConfigValue getValue(String key) {
    return remoteConfig.getValue(key);
  }


}
