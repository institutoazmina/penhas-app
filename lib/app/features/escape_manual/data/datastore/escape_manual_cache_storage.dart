import 'dart:convert';

import '../../../../core/extension/iterable.dart';
import '../../../../core/storage/cache_storage.dart';
import '../../../../core/storage/object_store.dart';
import '../model/escape_manual_remote.dart';

class EscapeManualCacheStorage extends IObjectStore<EscapeManualRemoteModel>
    with SerializableObjectStore<EscapeManualRemoteModel> {
  EscapeManualCacheStorage({
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

  @override
  Future<EscapeManualRemoteModel> save(EscapeManualRemoteModel value) async {
    final data = await _incrementalCache(value);
    return super.save(data);
  }

  Future<EscapeManualRemoteModel> _incrementalCache(
    EscapeManualRemoteModel newer,
  ) async {
    final cached = await retrieve();
    if (cached == null) return newer;

    final removedTasks = newer.removedTasks;
    final changedTasks = Map<String, EscapeManualTaskRemoteModel>.fromIterable(
      newer.tasks,
      key: (e) => '${e.id}',
    );

    final updatedTasks = cached.tasks
        .where((el) => !removedTasks.contains(el.id))
        .map((el) => changedTasks.remove(el.id) ?? el)
        .whereType<EscapeManualTaskRemoteModel>();

    return cached.copyWith(
      assistant: newer.assistant,
      tasks: updatedTasks + changedTasks.values,
    );
  }
}
