import 'i_local_storage.dart';
import 'local_storage_shared_preferences.dart';
import 'secure_local_storage.dart';

class MigratorLocalStorage implements ILocalStorage {
  MigratorLocalStorage({
    required LocalStorageSharedPreferences sharedPreferencesStorage,
    required SecureLocalStorage secureLocalStorage,
  })  : _secureLocalStorage = secureLocalStorage,
        _sharedPreferencesStorage = sharedPreferencesStorage;

  final LocalStorageSharedPreferences _sharedPreferencesStorage;
  final SecureLocalStorage _secureLocalStorage;

  @override
  Future<bool> hasKey(String key) async =>
      await _secureLocalStorage.hasKey(key) ||
      await _sharedPreferencesStorage.hasKey(key);

  @override
  Future<String?> get(String key) async {
    if (await _secureLocalStorage.hasKey(key)) {
      return _secureLocalStorage.get(key);
    }
    return _migrateFromPreferencesIfNeeded(key);
  }

  @override
  Future<void> put(String key, String? value) => Future.wait([
        _secureLocalStorage.put(key, value),
        _sharedPreferencesStorage.delete(key),
      ]);

  @override
  Future<void> delete(String key) => Future.wait([
        _sharedPreferencesStorage.delete(key),
        _secureLocalStorage.delete(key),
      ]);

  Future<String?> _migrateFromPreferencesIfNeeded(String key) async {
    final value = await _sharedPreferencesStorage.get(key);

    if (value == null) return null;

    await Future.wait([
      _secureLocalStorage.put(key, value),
      _sharedPreferencesStorage.delete(key),
    ]);

    return value;
  }
}
