import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/logger/log.dart';
import '../../../feed/domain/usecases/feed_use_cases.dart';
import '../../data/repositories/users_repository.dart';

@immutable
class BlockUserUseCase {
  const BlockUserUseCase({
    required IUsersRepository repository,
    required FeedUseCases feedUseCases,
  })  : _repository = repository,
        _feedUseCases = feedUseCases;

  final IUsersRepository _repository;
  final FeedUseCases _feedUseCases;

  Future<Either<Failure, ValidField>> call(String clientId) async {
    final result = await _repository.block(clientId);

    await _feedUseCases.reloadTweetFeed().catchError(catchErrorLogger);

    return result;
  }
}
