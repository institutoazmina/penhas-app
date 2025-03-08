import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> get offlineHash;

  Future<void> saveApiToken({required String? token});

  Future<void> saveHash({required String? hash});

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
    HiveInterface? hive,
  })  : penhasServer = Uri.parse(apiBaseUrl),
        _storage = storage,
        _hive = hive ?? Hive;

  final _tokenKey = 'br.com.penhas.tokenServer';
  final _appModes = 'br.com.penhas.appConfigurationModes';
  final _offlineHash = 'br.com.penhas.offlineHash';

  final ILocalStorage _storage;
  final HiveInterface _hive;

  @override
  Future<String> get apiToken =>
      _storage.get(_tokenKey).then((data) => data ?? '');

  @override
  Future<String> get offlineHash =>
      _storage.get(_offlineHash).then((data) => data ?? '');

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
  Future<void> saveHash({required String? hash}) async {
    await _storage.put(_offlineHash, hash);
    return;
  }

  @override
  Future<void> logout() async {
    await Future.wait([
      _storage.delete(_tokenKey),
      _storage.delete(_offlineHash),
      _hive.deleteFromDisk(),
    ]);
    await _clearUserData();
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

  Future<void> _clearUserData() async {
    await Future.wait([
      _clearCacheDir(),
      _clearAppDir(),
    ]);
  }

  Future<void> _clearCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync() && (Platform.isIOS || Platform.isAndroid)) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _clearAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
