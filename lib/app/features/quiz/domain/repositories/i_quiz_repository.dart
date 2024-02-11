import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../entities/quiz_request_entity.dart';

typedef QuizSessionResult = Future<Either<Failure, QuizSessionEntity>>;

abstract class IQuizRepository {
  QuizSessionResult start(String sessionId);

  Future<Either<Failure, AppStateEntity>> update({
    required QuizRequestEntity quiz,
  });
}
