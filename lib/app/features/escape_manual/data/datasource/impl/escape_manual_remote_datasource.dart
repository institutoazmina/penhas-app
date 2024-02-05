import 'dart:convert';

import '../../../../../core/extension/date_time.dart';
import '../../../../../core/extension/iterable.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/storage/object_store.dart';
import '../../../../../core/types/json.dart';
import '../../../../../shared/logger/log.dart';
import '../../../../appstate/data/model/quiz_session_model.dart';
import '../../model/escape_manual_remote.dart';
import '../../model/escape_manual_task.dart';
import '../escape_manual_datasource.dart';

export '../escape_manual_datasource.dart' show IEscapeManualRemoteDatasource;

class EscapeManualRemoteDatasource implements IEscapeManualRemoteDatasource {
  EscapeManualRemoteDatasource({
    required IApiProvider apiProvider,
    required IObjectStore<JsonObject> cacheStorage,
  })  : _apiProvider = apiProvider,
        _cacheStorage = cacheStorage;

  final IApiProvider _apiProvider;
  final IObjectStore<JsonObject> _cacheStorage;

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
    final lastChangeAt = cached?['consultado_em'] ?? 0;

    try {
      final response = await _apiProvider.get(
        path: '/me/tarefas',
        parameters: {
          'modificado_apos': '$lastChangeAt',
        },
      );

      final result = await _incrementalCache(
        cached: cached,
        newer: jsonDecode(response),
      );

      await _cacheStorage.save(result);

      return EscapeManualRemoteModel.fromJson(result);
    } catch (e, stack) {
      if (cached == null) rethrow;
      logError(e, stack);
      return EscapeManualRemoteModel.fromJson(cached);
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

  Future<JsonObject> _incrementalCache({
    required JsonObject? cached,
    required JsonObject newer,
  }) async {
    if (cached == null) return newer;

    final removedTasks =
        (newer['tarefas_removidas'] as JsonList).map((e) => '$e');
    final changedTasks = Map<String, JsonObject>.fromIterable(
      newer['tarefas'] as JsonList,
      key: (e) => '${(e as JsonObject)['id']}',
    );

    final updatedTasks = (cached['tarefas'] as JsonList)
        .cast<JsonObject>()
        .where((el) => !removedTasks.contains('${el['id']}'))
        .map((el) => changedTasks.remove('${el['id']}') ?? el)
        .whereType<JsonObject>();

    return {
      ...cached,
      'consultado_em': newer['consultado_em'],
      'mf_assistant': newer['mf_assistant'],
      'tarefas': updatedTasks + changedTasks.values,
    };
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
