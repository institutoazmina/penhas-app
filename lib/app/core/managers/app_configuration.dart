import 'dart:convert';

import '../../features/appstate/domain/entities/app_state_entity.dart';
import '../../shared/logger/log.dart';
import '../data/authorization_status.dart';
import '../storage/i_local_storage.dart';

const String _apiBaseUrl = String.fromEnvironment(
  'PENHAS_BASE_URL',
  defaultValue: 'https://api.penhas.com.br',
);

abstract class IAppConfiguration {
  Future<String> get apiToken;

  Future<String> get localPass;

  Future<void> saveApiToken({required String? token});

  Future<void> savePassword({required String? pass});

  Future<void> saveAppModes(AppStateModeEntity appMode);

  Future<void> logout();

  Uri get penhasServer;

  Future<AuthorizationStatus> get authorizationStatus;

  Future<AppStateModeEntity> get appMode;
}

class AppConfiguration implements IAppConfiguration {
  AppConfiguration({
    String apiBaseUrl = _apiBaseUrl,
    required ILocalStorage storage,
  })  : penhasServer = Uri.parse(apiBaseUrl),
        _storage = storage;

  final _tokenKey = 'br.com.penhas.tokenServer';
  final _appModes = 'br.com.penhas.appConfigurationModes';
  final _localPass = 'br.com.penhas.localPassword';

  final ILocalStorage _storage;

  @override
  Future<String> get apiToken =>
      _storage.get(_tokenKey).then((data) => data ?? '');

  @override
  Future<String> get localPass =>
      _storage.get(_localPass).then((data) => data ?? '');

  @override
  Future<AuthorizationStatus> get authorizationStatus async {
    var value = '';
    try {
      value = await apiToken;
    } catch (e, stack) {
      logError(e, stack);
    }
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
  Future<void> savePassword({required String? pass}) async {
    await _storage.put(_localPass, pass);
    return;
  }

  @override
  Future<void> logout() async {
    await _storage.delete(_tokenKey);
    await _storage.delete(_localPass);
    return;
  }

  @override
  Future<void> saveAppModes(AppStateModeEntity appMode) async {
    final value = jsonEncode(appMode.toJson());
    await _storage.put(_appModes, value);
    return;
  }

  @override
  Future<AppStateModeEntity> get appMode => _storage
      .get(_appModes)
      .then((value) => jsonDecode(value!))
      .then((value) => _buildAppStateMode(value))
      .catchError((error) => const AppStateModeEntity());

  AppStateModeEntity _buildAppStateMode(Map<String, dynamic> data) {
    return AppStateModeEntity(
      hasActivedGuardian: data['hasActivedGuardian'],
    );
  }
}
