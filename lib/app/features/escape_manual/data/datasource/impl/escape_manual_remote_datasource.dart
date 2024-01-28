import 'dart:convert';

import '../../../../../core/extension/date_time.dart';
import '../../../../../core/extension/iterable.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/storage/object_store.dart';
import '../../../../../shared/logger/log.dart';
import '../../../../appstate/data/model/quiz_session_model.dart';
import '../../model/escape_manual_remote.dart';
import '../../model/escape_manual_task.dart';
import '../escape_manual_datasource.dart';

export '../escape_manual_datasource.dart' show IEscapeManualRemoteDatasource;

class EscapeManualRemoteDatasource implements IEscapeManualRemoteDatasource {
  EscapeManualRemoteDatasource({
    required IApiProvider apiProvider,
    required IObjectStore<EscapeManualRemoteModel> cacheStorage,
  })  : _apiProvider = apiProvider,
        _cacheStorage = cacheStorage;

  final IApiProvider _apiProvider;
  final IObjectStore<EscapeManualRemoteModel> _cacheStorage;

  @override
  Future<QuizSessionModel> start(String sessionId) async {
    final response = await _apiProvider.post(
      path: '/me/quiz',
      parameters: {'session_id': sessionId},
    ).then(jsonDecode);

    return QuizSessionModel.fromJson(response['quiz_session']);
  }

  @override
  Future<EscapeManualRemoteModel> fetch() async {
    final cached = await _cacheStorage.retrieve();
    final lastChangeAt = cached?.lastModifiedAt.secondsSinceEpoch ?? 0;

    try {
      final response = await _apiProvider.get(
        path: '/me/tarefas',
        parameters: {
          'modificado_apos': '$lastChangeAt',
        },
      ).then(jsonDecode);

      final result = await _incrementalCache(
        cached: cached,
        newer: EscapeManualRemoteModel.fromJson(response),
      );

      await _cacheStorage.save(result);

      return result;
    } catch (e, stack) {
      if (cached == null) rethrow;
      logError(e, stack);
      return cached;
    }
  }

  @override
  Future<EscapeManualTaskModel> saveTask(EscapeManualTaskModel task) async {
    final response = await _apiProvider.request(
      method: 'POST',
      path: '/me/tarefas/batch',
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode([task.asRequest]),
    );

    final updatedAt = DateTimeExt.fromHttpFormat(response.headers['date']!);

    return task.copyWith(
      updatedAt: updatedAt,
    );
  }

  @override
  Future<List<EscapeManualTaskModel>> saveTasks(
    List<EscapeManualTaskModel> tasks,
  ) async {
    final response = await _apiProvider.request(
      method: 'POST',
      path: '/me/tarefas/batch',
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode(
        tasks.map((e) => e.asRequest).toList(),
      ),
    );

    final updatedAt = DateTimeExt.fromHttpFormat(response.headers['date']!);

    return tasks
        .map(
          (e) => e.copyWith(updatedAt: updatedAt),
        )
        .toList();
  }

  Future<EscapeManualRemoteModel> _incrementalCache({
    required EscapeManualRemoteModel? cached,
    required EscapeManualRemoteModel newer,
  }) async {
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
      lastModifiedAt: newer.lastModifiedAt,
      assistant: newer.assistant,
      tasks: updatedTasks + changedTasks.values,
    );
  }
}

extension EscapeManualTaskModelExt on EscapeManualTaskModel {
  Map<String, dynamic> get asRequest => {
        'id': id,
        'checkbox_feito': isDone ? 1 : 0,
        'campo_livre': value,
        'remove': isRemoved ? 1 : 0,
      };
}
