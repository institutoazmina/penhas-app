import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import 'entity/escape_manual.dart';
import 'repository/escape_manual_repository.dart';

class GetEscapeManualUseCase {
  const GetEscapeManualUseCase({
    required IEscapeManualRepository repository,
  }) : _repository = repository;

  final IEscapeManualRepository _repository;

  Future<Either<Failure, EscapeManualEntity>> call() => _repository.fetch();
}
