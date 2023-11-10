import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../../domain/entity/escape_manual.dart';
import '../../domain/repository/escape_manual_repository.dart';
import '../datasource/escape_manual_datasource.dart';
import '../model/escape_manual_mapper.dart';

export '../../domain/repository/escape_manual_repository.dart'
    show IEscapeManualRepository;

class EscapeManualRepository implements IEscapeManualRepository {
  EscapeManualRepository({
    required IEscapeManualRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

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
  Stream<EscapeManualEntity> fetch() async* {
    try {
      final response = await _remoteDatasource.fetch();

      yield response.asEntity;
    } catch (error, stack) {
      logError(error, stack);
      throw MapExceptionToFailure.map(error);
    }
  }
}
