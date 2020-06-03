import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

abstract class ITweetRepository {
  Future<Either<Failure, TweetSessionEntity>> retrieve(
      {@required TweetRequestOption option});
  Future<Either<Failure, TweetEntity>> like(
      {@required TweetEngageRequestOption option});
  Future<Either<Failure, ValidField>> create(
      {@required TweetCreateRequestOption option});
  Future<Either<Failure, ValidField>> report(
      {@required TweetEngageRequestOption option});
  Future<Either<Failure, ValidField>> comment(
      {@required TweetEngageRequestOption option});
}
