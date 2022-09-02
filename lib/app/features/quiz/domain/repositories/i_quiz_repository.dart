import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_request_entity.dart';

abstract class IQuizRepository {
  Future<Either<Failure, AppStateEntity>> update({
    required QuizRequestEntity quiz,
  });
}
