abstract class ILocalStorage {
  Future<String> get(String key);
  Future<void> put(String key, String value);
  Future<void> delete(String key);
}
