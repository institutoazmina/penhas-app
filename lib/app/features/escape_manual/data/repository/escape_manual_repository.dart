import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entity/escape_manual.dart';
import '../../domain/repository/escape_manual_repository.dart';
import '../datasource/escape_manual_datasource.dart';
import '../model/escape_manual.dart';

class EscapeManualRepository implements IEscapeManualRepository {
  EscapeManualRepository({
    required IEscapeManualLocalDatasource localDatasource,
    required IEscapeManualRemoteDatasource remoteDatasource,
  })  : _localDatasource = localDatasource,
        _remoteDatasource = remoteDatasource;

  final IEscapeManualLocalDatasource _localDatasource;
  final IEscapeManualRemoteDatasource _remoteDatasource;

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

  @override
  Future<Either<Failure, EscapeManualEntity>> fetch() async {
    try {
      final lastChangeAt = await _localDatasource.lastChangeAt();

      final response =
          await _remoteDatasource.fetch(lastChangeAt: lastChangeAt);
      await _localDatasource.saveAllTasks(response.tasks);

      final savedTasks = await _localDatasource.fetchTasks();
      final escapeManual = response.copyWith(tasks: savedTasks).toEntity();

      return right(escapeManual);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
