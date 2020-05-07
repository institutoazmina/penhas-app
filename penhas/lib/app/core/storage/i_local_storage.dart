abstract class ILocalStorage {
  Future<String> get(String key);
  Future put(String key, String value);
  Future delete(String key);
}
