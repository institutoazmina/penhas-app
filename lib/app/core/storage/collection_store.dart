import 'persistent_storage.dart';

abstract class ICollectionStore<T> {
  String get name;

  Future<Iterable<T>> all();

  Stream<Iterable<T>> watchAll();

  Future<void> put(String key, T value);

  Future<void> putAll(Map<String, T> values);

  Future<void> removeAll(Iterable<String> keys);
}

mixin SerializableCollectionStore<T> on ICollectionStore<T> {
  IPersistentStorageFactory get storageFactory;

  late final IPersistentStorage storage = storageFactory.create(name);

  T deserialize(String source);

  String serialize(T object);

  @override
  Future<Iterable<T>> all() =>
      storage.all<String>().then((value) => value.map(deserialize));

  @override
  Stream<Iterable<T>> watchAll() =>
      storage.watchAll<String>().map((value) => value.map(deserialize));

  @override
  Future<void> put(String key, T value) => storage.put(key, serialize(value));

  @override
  Future<void> putAll(Map<String, T> values) => storage.putAll(
        values.map(
          (key, value) => MapEntry(key, serialize(value)),
        ),
      );

  @override
  Future<void> removeAll(Iterable<String> keys) => storage.removeAll(keys);
}
