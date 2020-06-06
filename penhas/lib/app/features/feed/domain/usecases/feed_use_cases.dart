import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

class FeedUseCases {
  final ITweetRepository _repository;
  final _limitRows = 5;
  List<TweetEntity> _tweetList = List<TweetEntity>();

  FeedUseCases({
    @required ITweetRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  Future<Either<Failure, List<TweetEntity>>> fetchNewestTweet() async {
    final option = _newestRequestOption();
    final result = await _repository.retrieve(option: option);

    return result.fold<Either<Failure, List<TweetEntity>>>(
      (failure) => left(failure),
      (session) => right(_updateCache(session)),
    );
  }

  TweetRequestOption _newestRequestOption() {
    if (_tweetList.length == 0) {
      return TweetRequestOption(rows: _limitRows);
    } else {
      final firstId = _tweetList.first.id;
      return TweetRequestOption(rows: _limitRows, after: firstId);
    }
  }

  List<TweetEntity> _updateCache(TweetSessionEntity session) {
    if (session.tweets != null && session.tweets.length > 0) {
      _tweetList.insertAll(0, session.tweets);
    }

    return _tweetList;
  }
}
