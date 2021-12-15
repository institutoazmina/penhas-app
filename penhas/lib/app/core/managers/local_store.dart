import 'dart:convert';

import 'package:penhas/app/core/storage/i_local_storage.dart';

abstract class LocalStore<T> {
  LocalStore(this._key, this._storage);

  final ILocalStorage _storage;
  final String _key;

  Map<String, dynamic> toJson(T entity);

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T entity);

  T fromJson(Map<String, dynamic> json);

  T defaultEntity();

  Future<T> retrieve() {
    return _storage
        .get(_key)
        .then((data) => data.map((r) => json.decode(r)))
        .then((data) => data.map((r) => fromJson(r)))
        .then((value) => value.getOrElse(() => defaultEntity()));
  }

  Future<void> save(T entity) {
    final entityJson = toJson(entity);
    final jsonString = json.encode(entityJson);
    return _storage.put(_key, jsonString);
  }

  Future<void> delete() {
    return _storage.delete(_key);
  }
}
