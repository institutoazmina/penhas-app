import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';

abstract class ITweetFilterPreferenceRepository {
  Future<Either<Failure, TweetFilterSessionEntity>> retreive();
}
