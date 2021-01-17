import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/app_preferences_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

abstract class IAppPreferencesStore {
  Future<AppPreferencesEntity> retrieve();

  Future<void> save(AppPreferencesEntity appPreferences);

  Future<void> delete();
}

class AppPreferencesStore implements IAppPreferencesStore {
  final ILocalStorage _storage;
  final _key = 'br.com.penhas.app_preferences';

  AppPreferencesStore({@required ILocalStorage storage})
      : this._storage = storage;

  @override
  Future<void> delete() {
    return _storage.delete(_key);
  }

  @override
  Future<AppPreferencesEntity> retrieve() {
    return _storage
        .get(_key)
        .then((data) => json.decode(data) as Map<String, Object>)
        .then((json) => AppPreferencesModel.fromJson(json))
        .catchError((_) => _defaultModel());
  }

  Future<AppPreferencesModel> _defaultModel() {
    return Future.value(AppPreferencesModel(
      inactiveAppSince: null,
      inactiveAppLogoutTime: 30,
    ));
  }

  @override
  Future<void> save(AppPreferencesEntity appPreferences) {
    final preferencesJson = AppPreferencesModel(
      inactiveAppSince: appPreferences.inactiveAppSince,
      inactiveAppLogoutTime: appPreferences.inactiveAppLogoutTime,
    )..toJson();

    final jsonString = json.encode(preferencesJson);
    return _storage.put(_key, jsonString);
  }
}
