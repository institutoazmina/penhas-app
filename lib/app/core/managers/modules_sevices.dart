import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;

import '../../features/appstate/domain/entities/app_state_entity.dart';
import '../storage/i_local_storage.dart';

abstract class IAppModulesServices {
  Future<void> save(List<AppStateModuleEntity> modules);

  Future<bool> isEnabled(String name);

  Future<AppStateModuleEntity?> feature({required String name});
}

class AppModulesServices implements IAppModulesServices {
  AppModulesServices({required ILocalStorage storage}) : _storage = storage;

  final ILocalStorage _storage;
  final _appModuleKey = 'br.com.penhas.appModules';

  @override
  Future<void> save(List<AppStateModuleEntity> modules) {
    final data = modules.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(data);
    return _storage.put(_appModuleKey, jsonString);
  }

  @override
  Future<bool> isEnabled(String name) async {
    return await feature(name: name) != null;
  }

  @override
  Future<AppStateModuleEntity?> feature({required String name}) {
    return _storage
        .get(_appModuleKey)
        .then((value) => value ?? '[]')
        .then((source) => jsonDecode(source) as List<dynamic>)
        .then((value) => _filterFeature(name: name, objects: value));
  }

  AppStateModuleEntity? _filterFeature({
    String? name,
    required List<dynamic> objects,
  }) {
    final object = objects
        .map((e) => e as Map<String, dynamic>)
        .firstWhereOrNull((e) => e['code'] == name);

    if (object == null || object.isEmpty) {
      return null;
    }

    return AppStateModuleEntityJson.fromJson(object);
  }
}

extension AppStateModuleEntityJson on AppStateModuleEntity {
  Map<String, Object?> toJson() => {'code': code, 'meta': meta};

  static AppStateModuleEntity fromJson(Map<String, dynamic> object) =>
      AppStateModuleEntity(
        code: object['code'],
        meta: object['meta'],
      );
}
