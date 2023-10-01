abstract class IRemoteConfig {
  Future<void> initialize();

  bool getBool(String key);
}
