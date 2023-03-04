import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../data/repositories/users_repository.dart';

@immutable
class BlockUserUseCase {
  const BlockUserUseCase({
    required IUsersRepository repository,
  }) : _repository = repository;

  final IUsersRepository _repository;

  Future<Either<Failure, ValidField>> call(String clientId) =>
      _repository.block(clientId);
}
