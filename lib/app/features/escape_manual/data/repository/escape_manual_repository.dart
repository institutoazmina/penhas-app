import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/extension/date_time.dart';
import '../../../../core/extension/iterable.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entity/escape_manual.dart';
import '../../domain/repository/escape_manual_repository.dart';
import '../datasource/escape_manual_datasource.dart';
import '../model/escape_manual_local.dart';
import '../model/escape_manual_mapper.dart';
import '../model/escape_manual_remote.dart';
import '../model/escape_manual_task.dart';

export '../../domain/repository/escape_manual_repository.dart'
    show IEscapeManualRepository;

class EscapeManualRepository implements IEscapeManualRepository {
  EscapeManualRepository({
    required IEscapeManualLocalDatasource localDatasource,
    required IEscapeManualRemoteDatasource remoteDatasource,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource;

  final IEscapeManualLocalDatasource _localDatasource;
  final IEscapeManualRemoteDatasource _remoteDatasource;

  /// Start a escape manual quiz session
  ///
  /// [sessionId] is the id of the session to start
  /// Returns a [QuizSessionEntity] if success otherwise a [Failure]
  @override
  Future<Either<Failure, QuizSessionEntity>> start(String sessionId) async {
    try {
      final quizSession = await _remoteDatasource.start(sessionId);
      return right(quizSession);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  /// Fetch the escape manual
  /// It will fetch the remote data,
  /// remove the local data that is older than the remote data
  /// and emits new data every time the local data changes
  ///
  /// Returns a [Stream] of [EscapeManualEntity] if success
  /// or emits a [Failure] if something goes wrong
  @override
  Stream<EscapeManualEntity> fetch() async* {
    try {
      final response = await _remoteDatasource.fetch();

      await _localDatasource.clearBefore(response.lastModifiedAt);

      final iterator = StreamIterator(
        _localDatasource.fetchTasks().distinct(),
      );

      while (await iterator.moveNext()) {
        yield _updateFromLocal(response, iterator.current);
      }
    } catch (error, stack) {
      logError(error, stack);
      throw MapExceptionToFailure.map(error);
    }
  }

  /// Update a task from the escape manual locally
  @override
  VoidResult updateTask(EscapeManualTodoTaskEntity task) =>
      _saveInAllDataSources(task.asLocalModel);

  /// Remove a task from the escape manual locally
  @override
  VoidResult removeTask(EscapeManualTodoTaskEntity task) =>
      _saveInAllDataSources(
        task.asLocalModel.copyWith(isRemoved: true),
      );

  /// Send all pending tasks to the server
  /// Returns a [Failure] if something goes wrong
  /// or [void] if success
  @override
  VoidResult sendPendingTasks() async {
    try {
      final tasks = await _localDatasource.getTasks();
      final pendingTasks = tasks.where((el) => el.updatedAt == null).toList();
      if (pendingTasks.isEmpty) return right(null);

      final updatedTasks = await _remoteDatasource.saveTasks(pendingTasks);
      await _localDatasource.saveTasks(updatedTasks);

      return right(null);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  /// Apply local changes to the remote data
  /// if local task is newer than remote task
  /// or ignore the task if it was removed locally
  /// and return the updated remote data
  EscapeManualEntity _updateFromLocal(
    EscapeManualRemoteModel remote,
    Iterable<EscapeManualTaskModel> localTasks,
  ) {
    final tasksMap = Map<String, EscapeManualTaskModel>.fromIterable(
      localTasks,
      key: (el) => '${el.id}',
    );

    final tasks = remote.tasks.mapNotNull((remoteTask) {
      final localTask = tasksMap[remoteTask.id];

      if (localTask == null) return remoteTask;
      if (localTask.isRemoved) return null;

      final updatedAt = localTask.updatedAt ?? remoteTask.updatedAt;
      if (updatedAt < remoteTask.updatedAt) return remoteTask;

      return remoteTask.copyWith(
        isDone: localTask.isDone,
        value: localTask.value,
      );
    });

    return remote.copyWith(tasks: tasks).asEntity;
  }

  /// Save a task in all datasources
  VoidResult _saveInAllDataSources(
    EscapeManualTaskLocalModel model,
  ) async {
    try {
      final results = await Future.wait([
        // save in local datasource first to prevent losing data
        _localDatasource.saveTask(model),
        // save in remote datasource
        _remoteDatasource.saveTask(model),
      ]);

      // update local task from remote task containing the updatedAt
      await _localDatasource.saveTask(results[1]);

      return right(null);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
