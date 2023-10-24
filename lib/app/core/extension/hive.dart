import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../storage/i_local_storage.dart';

export 'package:hive_flutter/hive_flutter.dart';

const hiveKey = 'hive_key';

extension HiveExt on HiveInterface {
  void safeRegisterAdapter<T>(TypeAdapter<T> adapter) {
    if (!isAdapterRegistered(adapter.typeId)) {
      registerAdapter(adapter);
    }
  }

  Future<Box<T>> openSecureBox<T>(
    String name, {
    required ILocalStorage encryptionKeyStorage,
    String? path,
  }) async {
    final encryptionKey = await encryptionKeyStorage.getOrCreate(this);

    return openBox(
      name,
      path: path,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
  }
}

extension _EncryptionKeyStorage on ILocalStorage {
  Future<List<int>> getOrCreate(HiveInterface hive) async {
    final encryptionKeyString = await get(hiveKey);

    if (encryptionKeyString != null) {
      return base64Url.decode(encryptionKeyString);
    }

    return await create(hive);
  }

  Future<List<int>> create(HiveInterface hive) async {
    final encryptionKeyUint8List = hive.generateSecureKey();
    final encryptionKeyString = base64Url.encode(encryptionKeyUint8List);

    await put(hiveKey, encryptionKeyString);

    return encryptionKeyUint8List;
  }
}
