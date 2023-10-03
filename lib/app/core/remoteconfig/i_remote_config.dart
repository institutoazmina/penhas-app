abstract class IRemoteConfigService {
  Future<void> initialize();

  bool getBool(String key);
}
