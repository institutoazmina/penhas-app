import 'key_value_storage.dart';

abstract class IObjectStore<T> {
  String get name;

  Future<T?> retrieve();

  Future<T> save(T value);

  Future<void> delete();
}

mixin SerializableObjectStore<T> on IObjectStore<T> {
  IKeyValueStorage get storage;

  T deserialize(String data);

  String serialize(T data);

  @override
  Future<T?> retrieve() async {
    final data = await storage.getString(name);
    if (data == null) return null;
    return deserialize(data);
  }

  @override
  Future<T> save(T value) async {
    final data = serialize(value);
    await storage.put(name, data);
    return value;
  }

  @override
  Future<void> delete() => storage.remove(name);
}
