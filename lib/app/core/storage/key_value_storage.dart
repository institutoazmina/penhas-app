abstract class IKeyValueStorage {
  Future<T?> get<T>(String key);

  Future<void> put<T>(String key, T value);

  Future<void> remove(String key);

  Future<void> removeAll(Iterable<String> keys);

  Future<void> clear();
}

extension IKeyValueStorageExt on IKeyValueStorage {
  Future<String?> getString(String key) => get<String>(key);

  Future<void> putString(String key, String value) => put(key, value);
}
