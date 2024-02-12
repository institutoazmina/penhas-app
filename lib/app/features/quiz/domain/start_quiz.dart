import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import 'repositories/i_quiz_repository.dart';

class StartQuizUseCase {
  StartQuizUseCase({
    required IQuizRepository repository,
  }) : _repository = repository;

  final IQuizRepository _repository;

  QuizSessionResult call(String? sessionId) async {
    if (sessionId == null) {
      return left(InvalidArgumentsFailure());
    }
    return _repository.start(sessionId);
  }
}
