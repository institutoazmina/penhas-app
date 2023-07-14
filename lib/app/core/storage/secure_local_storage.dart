import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synchronized/extension.dart';

import 'i_local_storage.dart';

class SecureLocalStorage implements ILocalStorage {
  factory SecureLocalStorage({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) =>
      SecureLocalStorage._(storage, {});

  const SecureLocalStorage._(this._storage, this._cache);

  final FlutterSecureStorage _storage;
  final Map<String, dynamic> _cache;

  @override
  Future<bool> hasKey(String key) async =>
      _cache.containsKey(key) || await _storage.containsKey(key: key);

  @override
  Future<String?> get(String key) => synchronized(() async {
        return _cache[key] ?? (_cache[key] = await _storage.read(key: key));
      });

  @override
  Future<void> put(String key, String? value) => synchronized(() async {
        _cache[key] = value;
        await _storage.write(key: key, value: value);
      });

  @override
  Future<void> delete(String key) => synchronized(() async {
        await _storage.delete(key: key);
        _cache.remove(key);
      });
}
