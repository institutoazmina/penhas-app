import 'dart:async';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedPreferences implements ILocalStorage {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalStorageSharedPreferences() {
    _init();
  }

  @override
  Future delete(String key) async {
    final shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future<String> get(String key) async {
    final shared = await _instance.future;
    return shared.getString(key);
  }

  @override
  Future put(String key, String value) async {
    final shared = await _instance.future;
    shared.setString(key, value);
  }
}
