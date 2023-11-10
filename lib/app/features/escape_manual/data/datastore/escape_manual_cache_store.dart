import 'dart:convert';

import '../../../../core/storage/cache_storage.dart';
import '../../../../core/storage/object_store.dart';
import '../model/escape_manual_remote.dart';

class EscapeManualCacheStore extends IObjectStore<EscapeManualRemoteModel>
    with SerializableObjectStore<EscapeManualRemoteModel> {
  EscapeManualCacheStore({
    required this.storage,
  });

  @override
  final name = 'escape_manual_cache';

  @override
  final ICacheStorage storage;

  @override
  EscapeManualRemoteModel deserialize(String data) {
    final json = jsonDecode(data);
    return EscapeManualRemoteModel.fromJson(json);
  }

  @override
  String serialize(EscapeManualRemoteModel data) => jsonEncode(data);
}
