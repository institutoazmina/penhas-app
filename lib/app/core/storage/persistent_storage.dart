import 'key_value_storage.dart';

export 'key_value_storage.dart' show IKeyValueStorageExt;

abstract class IPersistentStorage extends IKeyValueStorage {
  Future<Iterable<T>> all<T>();

  Stream<Iterable<T>> watchAll<T>();
}

abstract class IPersistentStorageFactory {
  IPersistentStorage create(String name);
}
