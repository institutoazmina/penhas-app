import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'dart:convert';

abstract class LocalStore<T> {
  final ILocalStorage _storage;
  final String _key;

  LocalStore(this._key, this._storage);

  Map<String, Object> toJson(T entity);
  T fromJson(Map<String, Object> json);
  Future<T> defaultEntity();

  Future<T> retrieve() {
    return _storage
        .get(_key)
        .then((data) => json.decode(data) as Map<String, Object>)
        .then((json) => fromJson(json))
        .catchError((_) => defaultEntity());
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
