import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

abstract class ITweetRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retreive();
}

class TweetFilterPreference {
  final ITweetRepository _repository;

  TweetFilterPreference({@required ITweetRepository repository})
      : _repository = repository;

  Future<Either<Failure, TweetFilterSessionEntity>> retreive() async {
    return _repository.retreive();
  }
}
