import 'dart:async';

import '../../../../../core/extension/iterable.dart';
import '../../../../../core/storage/collection_store.dart';
import '../../model/escape_manual_task.dart';
import '../escape_manual_datasource.dart';

export '../escape_manual_datasource.dart' show IEscapeManualLocalDatasource;

class EscapeManualLocalDatasource implements IEscapeManualLocalDatasource {
  EscapeManualLocalDatasource({
    required ICollectionStore<EscapeManualTaskModel> store,
  }) : _store = store;

  final ICollectionStore<EscapeManualTaskModel> _store;

  @override
  Stream<Iterable<EscapeManualTaskModel>> fetchTasks() => _store.watchAll();

  @override
  Future<EscapeManualTaskModel> saveTask(EscapeManualTaskModel task) async {
    await _store.put(task.id, task);
    return task;
  }

  @override
  Future<void> clearBefore(DateTime date) async {
    final tasks = await _store.all();
    final keys = tasks.mapNotNull((task) {
      if (task.updatedAt?.isBefore(date) == true) {
        return task.id;
      }
      return null;
    });

    await _store.removeAll(keys);
  }
}
