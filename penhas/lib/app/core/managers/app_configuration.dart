import 'dart:convert';

import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

const String _apiBaseUrl = String.fromEnvironment(
  'env.apiBaseUrl',
  defaultValue: 'https://***REMOVED***',
);

abstract class IAppConfiguration {
  Future<String> get apiToken;

  Future<void> saveApiToken({required String? token});

  Future<void> saveAppModes(AppStateModeEntity appMode);

  Future<void> logout();

  Uri get penhasServer;

  Future<AuthorizationStatus> get authorizationStatus;

  Future<AppStateModeEntity> get appMode;
}

class AppConfiguration implements IAppConfiguration {
  AppConfiguration({
    required String? apiBaseUrl,
    required ILocalStorage storage,
  })  : penhasServer = Uri.parse(apiBaseUrl ?? _apiBaseUrl),
        _storage = storage;

  final _tokenKey = 'br.com.penhas.tokenServer';
  final _appModes = 'br.com.penhas.appConfigurationModes';
  final ILocalStorage _storage;

  @override
  Future<String> get apiToken {
    return _storage.get(_tokenKey).then((value) => value.getOrElse(() => ''));
  }

  @override
  Future<AuthorizationStatus> get authorizationStatus async {
    final value = await apiToken;
    return value.isEmpty
        ? AuthorizationStatus.anonymous
        : AuthorizationStatus.authenticated;
  }

  @override
  final Uri penhasServer;

  @override
  Future<void> saveApiToken({required String? token}) async {
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
        .then((source) => source.map((r) => jsonDecode(r)))
        .then((value) => value.map((r) => _buildAppStateMode(r)))
        .then((value) => value.getOrElse(() => const AppStateModeEntity()));
  }

  AppStateModeEntity _buildAppStateMode(Map<String, dynamic> data) {
    return AppStateModeEntity(
      hasActivedGuardian: data['hasActivedGuardian'],
    );
  }
}
