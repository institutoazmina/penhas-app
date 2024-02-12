abstract class IObjectStore<T extends Object> {
  String get name;

  Future<T?> retrieve();

  Future<void> save(T value);

  Future<void> delete();
}
