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
  Future<Iterable<EscapeManualTaskModel>> getTasks() => _store.all();

  @override
  Stream<Iterable<EscapeManualTaskModel>> fetchTasks() => _store.watchAll();

  @override
  Future<EscapeManualTaskModel> saveTask(EscapeManualTaskModel task) async {
    await _store.put(task.id, task);
    return task;
  }

  @override
  Future<List<EscapeManualTaskModel>> saveTasks(
    List<EscapeManualTaskModel> tasks,
  ) async {
    final tasksMap = Map<String, EscapeManualTaskModel>.fromIterable(
      tasks,
      key: (task) => task.id,
    );
    await _store.putAll(tasksMap);
    return tasks;
  }

  @override
  Future<void> removeWhere({
    required DateTime isBefore,
    required List<String> orIdNotIn,
  }) async {
    final tasks = await _store.all();
    final keys = tasks.mapNotNull((task) {
      if (task.updatedAt?.isBefore(isBefore) == true) {
        return task.id;
      }
      if (!orIdNotIn.contains(task.id)) {
        return task.id;
      }
      return null;
    });

    await _store.removeAll(keys);
  }
}
