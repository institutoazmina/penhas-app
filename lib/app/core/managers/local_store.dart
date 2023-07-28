import 'dart:convert';

import '../storage/i_local_storage.dart';

abstract class LocalStore<T> {
  LocalStore(this._key, this._storage);

  final ILocalStorage _storage;
  final String _key;

  Map<String, dynamic> toJson(T entity);

  T fromJson(Map<String, dynamic> json);

  T defaultEntity();

  Future<T> retrieve() {
    return _storage
        .get(_key)
        .then((data) => json.decode(data!))
        .then((data) => fromJson(data))
        .catchError((error) => defaultEntity());
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
