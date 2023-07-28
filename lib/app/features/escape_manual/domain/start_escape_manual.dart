import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../appstate/domain/entities/app_state_entity.dart';
import 'repository/escape_manual_repository.dart';

class StartEscapeManualUseCase {
  StartEscapeManualUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Future<Either<Failure, QuizSessionEntity>> call(
    QuizSessionEntity quizSession,
  ) async {
    if (quizSession.sessionId.startsWith('MF')) {
      return _repository.start(quizSession.sessionId);
    }

    return right(quizSession);
  }
}
