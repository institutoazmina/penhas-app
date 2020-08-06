import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

abstract class IAppModulesServices {
  Future<void> save(List<AppStateModuleEntity> modules);
  Future<AppStateModuleEntity> feature({@required String name});
}

class AppModulesServices implements IAppModulesServices {
  final ILocalStorage _storage;
  final _appModuleKey = 'br.com.penhas.appModules';

  AppModulesServices({@required ILocalStorage storage})
      : this._storage = storage;

  @override
  Future<void> save(List<AppStateModuleEntity> modules) {
    final foo = modules.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(foo);
    return _storage.put(_appModuleKey, jsonString);
  }

  @override
  Future<AppStateModuleEntity> feature({@required String name}) {
    return _storage
        .get(_appModuleKey)
        .then((source) => jsonDecode(source) as List<Object>)
        .then((value) => _filterFeature(name: name, objects: value));
  }

  AppStateModuleEntity _filterFeature({String name, List<Object> objects}) {
    final object = objects
        .map((e) => e as Map<String, Object>)
        .firstWhere((e) => e['code'] == name, orElse: () => null);

    if (object == null || object.isEmpty) {
      return null;
    }

    return AppStateModuleEntityJson.fromJson(object);
  }
}

extension AppStateModuleEntityJson on AppStateModuleEntity {
  Map<String, Object> toJson() => {'code': this.code, 'meta': this.meta};

  static AppStateModuleEntity fromJson(Map<String, Object> object) =>
      AppStateModuleEntity(
        code: object['code'],
        meta: object['meta'],
      );
}
