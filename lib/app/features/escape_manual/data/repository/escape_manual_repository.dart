import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import '../../domain/entity/escape_manual.dart';
import '../../domain/repository/escape_manual_repository.dart';
import '../datasource/escape_manual_datasource.dart';

class EscapeManualRepository implements IEscapeManualRepository {
  EscapeManualRepository({
    required IEscapeManualDatasource datasource,
  }) : _datasource = datasource;

  final IEscapeManualDatasource _datasource;

  @override
  Future<Either<Failure, QuizSessionEntity>> start(String sessionId) {
    return _datasource.start(sessionId);
  }

  @override
  Future<Either<Failure, EscapeManualEntity>> fetch() {
    return _datasource.fetch();
  }
}
