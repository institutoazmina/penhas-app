import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

abstract class IAppConfiguration {
  Future<String> get apiToken;
  Future<void> saveApiToken({@required String token});
  Future<void> saveAppModes(AppStateModeEntity appMode);
  Future<void> logout();
  Uri get penhasServer;
  Future<AuthorizationStatus> get authorizationStatus;
  Future<AppStateModeEntity> get appMode;
}

class AppConfiguration implements IAppConfiguration {
  final _tokenKey = 'br.com.penhas.tokenServer';
  final _appModes = 'br.com.penhas.appConfigurationModes';
  final ILocalStorage _storage;

  AppConfiguration({@required ILocalStorage storage}) : this._storage = storage;

  @override
  Future<String> get apiToken {
    return _storage.get(_tokenKey);
  }

  @override
  Future<AuthorizationStatus> get authorizationStatus async {
    final value = await apiToken;
    return value == null
        ? AuthorizationStatus.anonymous
        : AuthorizationStatus.authenticated;
  }

  @override
  Uri get penhasServer => Uri.https('elasv2-api.appcivico.com', '/');

  @override
  Future<void> saveApiToken({@required String token}) async {
    await _storage.put(_tokenKey, token);
    return;
  }

  @override
  Future<void> logout() async {
    await _storage.delete(_tokenKey);
    return;
  }

  @override
  Future<void> saveAppModes(AppStateModeEntity appMode) async {
    final value = jsonEncode(appMode.toJson());
    await _storage.put(_appModes, value);
    return;
  }

  @override
  Future<AppStateModeEntity> get appMode async {
    return _storage
        .get(_appModes)
        .then((source) => jsonDecode(source))
        .then((v) => v as Map<String, Object>)
        .then((v) => _buildAppStateMode(v))
        .catchError((_) => null);
  }

  AppStateModeEntity _buildAppStateMode(Map<String, Object> data) {
    return AppStateModeEntity(
      hasActivedGuardian: data['hasActivedGuardian'],
    );
  }
}
