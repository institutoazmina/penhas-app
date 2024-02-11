import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../domain/start_quiz.dart';

class QuizStartController {
  QuizStartController({
    required String? sessionId,
    required StartQuizUseCase startQuiz,
  })  : _sessionId = sessionId,
        _startQuiz = startQuiz;

  final String? _sessionId;
  final StartQuizUseCase _startQuiz;

  Future<void> start() async {
    final result = await _startQuiz(_sessionId);

    result.fold(_handleFailure, _handleSuccess);
  }

  void _handleFailure(Failure failure) {
    Modular.to.pop(left(failure));
  }

  void _handleSuccess(QuizSessionEntity session) {
    Modular.to.pushNamed('/quiz', arguments: session).then(
      (value) {
        Modular.to.pop(right<Failure, void>(null));
      },
      onError: (error, stack) {
        logError(error, stack);
        final failure = error is Failure ? error : UnknownFailure();
        Modular.to.pop(left(failure));
      },
    );
  }
}
