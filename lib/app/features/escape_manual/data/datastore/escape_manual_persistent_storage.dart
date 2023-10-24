import 'dart:convert';

import '../../../../core/storage/collection_store.dart';
import '../../../../core/storage/persistent_storage.dart';
import '../model/escape_manual_local.dart';

class EscapeManualTasksStore
    extends ICollectionStore<EscapeManualTaskLocalModel>
    with CollectionStore, SerializableCollectionStore {
  EscapeManualTasksStore({
    required this.storageFactory,
  });

  @override
  final name = 'escape_manual_tasks';

  @override
  final IPersistentStorageFactory storageFactory;

  @override
  EscapeManualTaskLocalModel deserialize(String source) =>
      EscapeManualTaskLocalModel.fromJson(jsonDecode(source));

  @override
  String serialize(EscapeManualTaskLocalModel object) =>
      jsonEncode(object.toJson());
}
