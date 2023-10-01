import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class IRemoteConfig {
  Future<void> fetch() async {}

  Future<void> setConfigSettings() async {}

  Future<void> activate() async {}

  Future<void> setDefaults() async {}

  Map<String, RemoteConfigValue> getAll() {
    return {};
  }

  RemoteConfigValue getValue(String key) {
    return '' as RemoteConfigValue;
  }
}
