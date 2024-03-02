export 'remote_config_keys.dart';

abstract class IRemoteConfigService {
  Future<void> initialize();

  bool getBool(String key);

  int getInt(String key);

  List<T> getList<T extends Object>(String key);
}
