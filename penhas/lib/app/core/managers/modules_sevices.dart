import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

abstract class IAppModulesServices {
  Future<void> save(List<AppStateModuleEntity> modules);
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
}

extension AppStateModuleEntityJson on AppStateModuleEntity {
  Map<String, Object> toJson() => {'code': this.code, 'meta': this.meta};
}
