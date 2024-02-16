import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../entity/escape_manual.dart';

typedef VoidResult = Future<Either<Failure, void>>;

abstract class IEscapeManualRepository {
  Future<Either<Failure, QuizSessionEntity>> start(String sessionId);
  Stream<EscapeManualEntity> fetch();
  VoidResult updateTask(EscapeManualTodoTaskEntity task);
  VoidResult removeTask(EscapeManualTodoTaskEntity task);
  VoidResult sendPendingTasks();
}
