import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../entity/escape_manual.dart';

typedef QuizSessionResult = Future<Either<Failure, QuizSessionEntity>>;
typedef EscapeManualResult = Future<Either<Failure, EscapeManualEntity>>;
typedef VoidResult = Future<Either<Failure, void>>;

abstract class IEscapeManualRepository {
  QuizSessionResult start(String sessionId);
  QuizSessionResult resume(QuizSessionEntity quizSession);
  Stream<EscapeManualEntity> fetch();
  VoidResult updateTask(EscapeManualTaskEntity task);
  VoidResult removeTask(EscapeManualTaskEntity task);
  VoidResult sendPendingTasks();
}
