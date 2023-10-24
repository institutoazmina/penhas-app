import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'i_local_storage.dart';

const hiveKey = 'hive_key';
const defaultBoxKey = 'penhas_box';

class HiveLocalStorage extends ILocalStorage {
  HiveLocalStorage._(this._storage, this._box);

  factory HiveLocalStorage({
    LazyBox<String>? box,
    FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(resetOnError: true),
    ),
  }) =>
      HiveLocalStorage._(storage, box);

  final FlutterSecureStorage _storage;

  LazyBox<String>? _box;

  Future<LazyBox<String>> get _lazyBox async =>
      _box ??= await _openLazyBox(_storage);

  @override
  Future<bool> hasKey(String key) async {
    final box = await _lazyBox;
    return box.containsKey(key);
  }

  @override
  Future<String?> get(String key) async {
    final box = await _lazyBox;
    return box.get(key);
  }

  @override
  Future<void> put(String key, String? value) async {
    if (value == null) return delete(key);

    final box = await _lazyBox;
    await box.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    final box = await _lazyBox;
    await box.delete(key);
  }
}

Future<LazyBox<T>> _openLazyBox<T>(FlutterSecureStorage storage) async {
  late final List<int> encryptionKeyUint8List;
  final encryptionKeyString = await storage.read(key: hiveKey);

  if (encryptionKeyString != null) {
    encryptionKeyUint8List = base64Url.decode(encryptionKeyString);
  } else {
    encryptionKeyUint8List = Hive.generateSecureKey();
    await storage.write(
      key: hiveKey,
      value: base64UrlEncode(encryptionKeyUint8List),
    );
  }

  return Hive.openLazyBox(
    defaultBoxKey,
    encryptionCipher: HiveAesCipher(encryptionKeyUint8List),
  );
}
