import 'dart:convert';

import '../../types/json.dart';
import '../key_value_storage.dart';
import '../object_store.dart';

class JsonObjectStore extends IObjectStore<JsonObject> {
  JsonObjectStore({
    required this.name,
    required this.storage,
  });

  @override
  final String name;
  final IKeyValueStorage storage;

  @override
  Future<JsonObject?> retrieve() async {
    final data = await storage.getString(name);
    if (data == null) return null;
    final jsonObject = jsonDecode(data) as JsonObject;
    return jsonObject;
  }

  @override
  Future<void> save(JsonObject value) async {
    final jsonString = jsonEncode(value);
    await storage.put(name, jsonString);
  }

  @override
  Future<void> delete() => storage.remove(name);
}
