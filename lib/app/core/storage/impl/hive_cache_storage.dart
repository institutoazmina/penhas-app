import 'dart:async';

import 'package:path_provider/path_provider.dart';

import '../../extension/hive.dart';
import '../cache_storage.dart';
import '../i_local_storage.dart';
import 'hive_storage_mixin.dart';

const cacheBoxName = 'penhas_cache_box';

class HiveCacheStorage extends ICacheStorage with HiveStorage {
  HiveCacheStorage({
    String name = cacheBoxName,
    required ILocalStorage encryptionKeyStorage,
    HiveInterface? hive,
    Box? box,
  })  : _name = name,
        _encryptionKeyStorage = encryptionKeyStorage,
        _hive = hive ?? Hive,
        _box = box;

  final String _name;
  final ILocalStorage _encryptionKeyStorage;
  final HiveInterface _hive;
  Box? _box;

  @override
  Future<Box> get box async => _box ??= await _hive.openSecureBox(
        _name,
        encryptionKeyStorage: _encryptionKeyStorage,
        path: (await getTemporaryDirectory()).path,
      );
}
