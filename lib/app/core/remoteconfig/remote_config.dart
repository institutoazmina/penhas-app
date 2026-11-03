import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:meta/meta.dart';

import '../../shared/logger/log.dart';
import 'i_remote_config.dart';

class RemoteConfigService implements IRemoteConfigService {
  RemoteConfigService();

  static FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  StreamSubscription<RemoteConfigUpdate>? _updatesSubscription;

  @visibleForTesting
  static set remoteConfig(FirebaseRemoteConfig value) => _remoteConfig = value;

  @override
  Future<void> initialize() async {
    try {
      await _setDefaults();
      await _setConfigSettings();
      _listenForUpdates();
      await refresh();
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  @override
  Future<bool> refresh() async {
    try {
      return await _remoteConfig
          .fetchAndActivate()
          .timeout(const Duration(seconds: 5));
    } catch (e, stack) {
      logError(e, stack);
      return false;
    }
  }

  Future<void> _setConfigSettings() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  void _listenForUpdates() {
    _updatesSubscription ??= _remoteConfig.onConfigUpdated.listen(
      (_) => _remoteConfig.activate().catchError((error, stack) {
        logError(error, stack);
        return false;
      }),
      onError: (Object error, StackTrace stack) => logError(error, stack),
    );
  }

  Future<void> _setDefaults() async {
    await _remoteConfig.setDefaults(RemoteConfigKeys.defaults);
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  int getInt(String key) => _remoteConfig.getInt(key);

  @override
  List<T> getList<T extends Object>(String key) {
    final value = _remoteConfig.getString(key);
    final jsonValue = jsonDecode(value);

    if (jsonValue is! List) return const [];

    return jsonValue.whereType<T>().toList();
  }
}
