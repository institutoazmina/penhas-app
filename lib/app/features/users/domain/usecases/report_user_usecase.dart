import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/users_repository.dart';

@immutable
class ReportUserUseCase {
  const ReportUserUseCase({
    required IUsersRepository repository,
  }) : _repository = repository;

  final IUsersRepository _repository;

  Future<Either<Failure, ValidField>> call({
    required String clientId,
    required String reason,
  }) =>
      _repository.report(clientId, reason);
}
