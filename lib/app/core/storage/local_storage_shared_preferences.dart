import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/extension.dart';

import 'i_local_storage.dart';

class LocalStorageSharedPreferences implements ILocalStorage {
  factory LocalStorageSharedPreferences({
    required Future<SharedPreferences> preferences,
  }) =>
      LocalStorageSharedPreferences._(
        preferences: Completer<SharedPreferences>()..complete(preferences),
      );

  const LocalStorageSharedPreferences._({
    required Completer<SharedPreferences> preferences,
  }) : _preferences = preferences;

  final Completer<SharedPreferences> _preferences;

  @override
  Future<void> delete(String key) => synchronized(() async {
        final preferences = await _preferences.future;
        await preferences.remove(key);
      });

  @override
  Future<bool> hasKey(String key) =>
      _preferences.future.then((preferences) => preferences.containsKey(key));

  @override
  Future<String?> get(String key) => synchronized(
        () async => _preferences.future.then(
          (preferences) => preferences.getString(key),
        ),
      );

  @override
  Future<void> put(String key, String? value) => synchronized(() async {
        final preferences = await _preferences.future;
        if (value != null) {
          await preferences.setString(key, value);
        } else {
          await preferences.remove(key);
        }
      });
}
