export 'remote_config_keys.dart';

abstract class IRemoteConfigService {
  Future<void> initialize();

  bool getBool(String key);
}
