import 'dart:async';

import '../../extension/hive.dart';
import '../i_local_storage.dart';
import '../persistent_storage.dart';
import 'hive_storage_mixin.dart';

class HivePersistentStorageFactory extends IPersistentStorageFactory {
  HivePersistentStorageFactory({
    required ILocalStorage encryptionKeyStorage,
  }) : _encryptionKeyStorage = encryptionKeyStorage;

  final ILocalStorage _encryptionKeyStorage;

  @override
  IPersistentStorage create(String name) => HivePersistentStorage(
        name: name,
        encryptionKeyStorage: _encryptionKeyStorage,
      );
}

class HivePersistentStorage extends IPersistentStorage with HiveStorage {
  HivePersistentStorage({
    required String name,
    required ILocalStorage encryptionKeyStorage,
    Box? box,
  })  : _name = name,
        _encryptionKeyStorage = encryptionKeyStorage,
        _box = box;

  final String _name;
  final ILocalStorage _encryptionKeyStorage;

  Box? _box;

  @override
  Future<Box> get box async => _box ??= await Hive.openSecureBox(
        _name,
        encryptionKeyStorage: _encryptionKeyStorage,
      );

  @override
  Future<Iterable<T>> all<T>() async {
    final box = await this.box;
    return box.values.whereType();
  }

  @override
  Stream<Iterable<T>> watchAll<T>() async* {
    final box = await this.box;
    final iterable = StreamIterator(box.watch());

    do {
      yield box.values.whereType();
    } while (await iterable.moveNext());
  }
}
