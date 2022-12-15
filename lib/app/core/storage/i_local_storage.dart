abstract class ILocalStorage {
  Future<bool> hasKey(String key);

  Future<String?> get(String key);

  Future<void> put(String key, String? value);

  Future<void> delete(String key);
}
