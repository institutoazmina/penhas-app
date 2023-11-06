import 'dart:async';

import '../../extension/hive.dart';
import '../i_local_storage.dart';
import '../persistent_storage.dart';
import 'hive_storage_mixin.dart';

/// Factory to create [IPersistentStorage] with Hive implementation.
class HivePersistentStorageFactory extends IPersistentStorageFactory {
  /// Creates a [HivePersistentStorageFactory].
  ///
  /// [encryptionKeyStorage] storage to retrieve the encryption key.
  /// [hive] is optional, it's used to inject a mock for testing.
  HivePersistentStorageFactory({
    required ILocalStorage encryptionKeyStorage,
    HiveInterface? hive,
  })  : _encryptionKeyStorage = encryptionKeyStorage,
        _hive = hive ?? Hive; // coverage:ignore-line

  final ILocalStorage _encryptionKeyStorage;
  final HiveInterface _hive;

  @override
  IPersistentStorage create(String name) => HivePersistentStorage(
        name: name,
        encryptionKeyStorage: _encryptionKeyStorage,
        hive: _hive,
      );
}

/// [IPersistentStorage] implementation with Hive.
class HivePersistentStorage extends IPersistentStorage with HiveStorage {
  /// Creates a [HivePersistentStorage].
  ///
  /// [name] name of the box to be opened.
  /// [encryptionKeyStorage] storage to retrieve the encryption key.
  /// [hive] is optional, it's used to inject a mock for testing.
  HivePersistentStorage({
    required String name,
    required ILocalStorage encryptionKeyStorage,
    HiveInterface? hive,
  })  : _name = name,
        _encryptionKeyStorage = encryptionKeyStorage,
        _hive = hive ?? Hive; // coverage:ignore-line

  final String _name;
  final ILocalStorage _encryptionKeyStorage;
  final HiveInterface _hive;

  Box? _box;

  @override
  Future<Box> get box async => _box ??= await _hive.openSecureBox(
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
