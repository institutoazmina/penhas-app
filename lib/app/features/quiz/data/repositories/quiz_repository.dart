import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../../core/error/api_provider_error_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/types/result.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/data/model/app_state_model.dart';
import '../../../appstate/data/model/quiz_session_model.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../domain/entities/answer.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/entities/quiz_request_entity.dart';
import '../../domain/quiz_mapper.dart';
import '../../domain/repositories/i_quiz_repository.dart';

class QuizRepository implements IQuizRepository {
  QuizRepository({required IApiProvider apiProvider})
      : _apiProvider = apiProvider;

  final IApiProvider _apiProvider;

  @override
  QuizSessionResult start(String sessionId) async {
    try {
      final quizSession = await _apiProvider
          .post(
            path: '/me/quiz',
            parameters: {'session_id': sessionId},
          )
          .then((value) => jsonDecode(value))
          .then((value) => QuizSessionModel.fromJson(value['quiz_session']));

      return right(quizSession);
    } catch (error, stack) {
      logError(error, stack);
      return left(ApiProviderErrorMapper.map(error));
    }
  }

  @override
  Future<Result<Quiz>> send({
    required String quizId,
    required UserAnswer answer,
  }) async {
    final appState = await update(
      quiz: QuizMapper.toRequest(quizId, answer),
    );

    return appState.fold(
      left,
      (appState) {
        final quiz = appState.quizSession;
        if (quiz == null) return left(ServerFailure());
        return right(QuizMapper.fromLegacy(quiz));
      },
    );
  }

  @override
  Future<Either<Failure, AppStateEntity>> update({
    required QuizRequestEntity quiz,
  }) async {
    try {
      final Map<String, String> queryParameters = {
        'session_id': '${quiz.sessionId}',
      };
      queryParameters.addAll(quiz.options);

      final response = await _apiProvider
          .post(
            path: '/me/quiz',
            parameters: queryParameters,
          )
          .then((value) => jsonDecode(value))
          .then((value) => AppStateModel.fromJson(value));

      return right(response);
    } catch (e, stack) {
      logError(e, stack);
      return left(ApiProviderErrorMapper.map(e));
    }
  }
}
