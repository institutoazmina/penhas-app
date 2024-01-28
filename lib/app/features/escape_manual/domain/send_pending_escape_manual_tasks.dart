import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import 'repository/escape_manual_repository.dart';

class SendPendingEscapeManualTasksUseCase {
  const SendPendingEscapeManualTasksUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Future<Either<Failure, void>> call() => _repository.sendPendingTasks();
}
