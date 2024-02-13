import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import 'entity/escape_manual.dart';
import 'repository/escape_manual_repository.dart';

class UpdateEscapeManualTaskUseCase {
  UpdateEscapeManualTaskUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Future<Either<Failure, void>> call(EscapeManualTodoTaskEntity escapeManual) =>
      _repository.updateTask(escapeManual);
}
