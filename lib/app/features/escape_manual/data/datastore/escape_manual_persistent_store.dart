import 'dart:convert';

import '../../../../core/storage/collection_store.dart';
import '../../../../core/storage/persistent_storage.dart';
import '../model/escape_manual_local.dart';
import '../model/escape_manual_task.dart';

class EscapeManualTasksStore extends ICollectionStore<EscapeManualTaskModel>
    with SerializableCollectionStore {
  EscapeManualTasksStore({
    required this.storageFactory,
  });

  @override
  final name = 'escape_manual_tasks';

  @override
  final IPersistentStorageFactory storageFactory;

  @override
  EscapeManualTaskModel deserialize(String source) =>
      EscapeManualTaskLocalModel.fromJson(jsonDecode(source));

  @override
  String serialize(EscapeManualTaskModel object) => jsonEncode(object.toJson());
}
