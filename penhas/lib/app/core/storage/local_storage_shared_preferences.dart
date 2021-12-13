import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/exceptions.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedPreferences implements ILocalStorage {
  LocalStorageSharedPreferences() {
    _init();
  }

  final Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  Future<void> _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  @override
  Future<void> delete(String key) async {
    final shared = await _instance.future;
    shared.remove(key);
  }

  @override
  Future<Either<dynamic, String>> get(String key) async {
    final shared = await _instance.future;
    return catching(() {
      final value = shared.getString(key);
      if (value == null) throw ValueNotFound("Value not found with key `$key`");
      return value;
    });
  }

  @override
  Future<void> put(String key, String? value) async {
    final shared = await _instance.future;
    if (value != null) {
      shared.setString(key, value);
    } else {
      shared.remove(key);
    }
  }
}

class ValueNotFound extends HandledException {
  ValueNotFound(String message) : super(message);
}
