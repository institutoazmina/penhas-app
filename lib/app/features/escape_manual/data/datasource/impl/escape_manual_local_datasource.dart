import 'package:sqflite/sqflite.dart';

import '../../../../../core/storage/db.dart';
import '../../model/escape_manual.dart';
import '../../model/escape_manual_local.dart';
import '../escape_manual_datasource.dart';

class EscapeManualLocalDatasource implements IEscapeManualLocalDatasource {
  EscapeManualLocalDatasource({
    required DbProvider dbProvider,
  }) : _dbProvider = dbProvider;

  final DbProvider _dbProvider;

  @override
  Future<int> lastChangeAt() async {
    final db = await _dbProvider.database;
    final result = await db.rawQuery(
      '''
      SELECT COALESCE(MAX(updated_at), 0) as last_change_at
      FROM escape_manual_tasks
      ''',
    );
    return result[0]['last_change_at'] as int;
  }

  @override
  Future<Iterable<EscapeManualTaskModel>> fetchTasks() async {
    final db = await _dbProvider.database;
    final result = await db.query(
      'escape_manual_tasks',
      where: 'is_removed != 1',
    );
    return result.map(EscapeManualTaskLocalModel.fromMap);
  }

  @override
  Future<void> saveTask(EscapeManualTaskModel task) async {
    final db = await _dbProvider.database;
    await upInsert(db, task);
  }

  @override
  Future<void> saveAllTasks(Iterable<EscapeManualTaskModel> items) async {
    final db = await _dbProvider.database;
    db.transaction(
      (txn) => Future.wait(
        items.map((e) => upInsert(txn, e)),
      ),
    );
  }

  @override
  Future<void> removeTask(EscapeManualTaskModel task) async {
    final db = await _dbProvider.database;
    await db.update(
      'escape_manual_tasks',
      {'is_removed': 1},
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> upInsert(DatabaseExecutor db, EscapeManualTaskModel task) async {
    await db.insert(
      'escape_manual_tasks',
      {
        'id': task.id,
        'type': task.type,
        'group': task.group,
        'title': task.title,
        'description': task.description,
        'is_editable': task.isEditable ? 1 : 0,
        'user_input_value': task.userInputValue,
        'is_done': task.isDone ? 1 : 0,
        'updated_at': task.updatedAt,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
