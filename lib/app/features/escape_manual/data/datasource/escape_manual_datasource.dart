import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/data/model/quiz_session_model.dart';
import '../../../authentication/presentation/shared/map_exception_to_failure.dart';
import '../model/escape_manual.dart';

abstract class IEscapeManualDatasource {
  Future<Either<Failure, QuizSessionModel>> start(String sessionId);
  Future<Either<Failure, EscapeManualModel>> fetch();
}

class EscapeManualDatasource implements IEscapeManualDatasource {
  EscapeManualDatasource({
    required IApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  Future<Either<Failure, QuizSessionModel>> start(String sessionId) async {
    try {
      final response = await _apiProvider.post(
        path: '/me/quiz',
        parameters: {'session_id': sessionId},
      ).then(jsonDecode);

      final quizSession = QuizSessionModel.fromJson(response);
      return right(quizSession);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }

  @override
  Future<Either<Failure, EscapeManualModel>> fetch() async {
    try {
      final response = await _apiProvider.get(
        path: '/me/tarefas',
        parameters: {
          'modificado_apos': '0',
        },
      ).then(jsonDecode);

      final escapeManual = EscapeManualModel.fromJson(response);
      return right(escapeManual);
    } catch (error, stack) {
      logError(error, stack);
      return left(MapExceptionToFailure.map(error));
    }
  }
}
