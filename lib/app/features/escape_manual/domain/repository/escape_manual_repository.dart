import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../entity/escape_manual.dart';

abstract class IEscapeManualRepository {
  Future<Either<Failure, QuizSessionEntity>> start(String sessionId);
  Stream<EscapeManualEntity> fetch();
}
