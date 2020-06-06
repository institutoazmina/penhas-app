import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

@immutable
class FeedCache extends Equatable {
  final List<TweetEntity> tweets;

  FeedCache({@required this.tweets});

  @override
  List<Object> get props => [tweets];

  @override
  bool get stringify => true;
}

class FeedUseCases {
  final ITweetRepository _repository;
  final int _maxRowsPerRequest;
  List<TweetEntity> _tweetCacheFetch = List<TweetEntity>();

  FeedUseCases({
    @required ITweetRepository repository,
    int maxRows = 100,
  })  : assert(repository != null),
        _repository = repository,
        _maxRowsPerRequest = maxRows;

  Future<Either<Failure, FeedCache>> fetchNewestTweet() async {
    final option = _newestRequestOption();
    final result = await _repository.retrieve(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_updateCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> fetchOldestTweet() async {
    final option = _oldestRequestOption();
    final result = await _repository.retrieve(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_appendCache(session)),
    );
  }

  TweetRequestOption _newestRequestOption() {
    if (_tweetCacheFetch.length == 0) {
      return TweetRequestOption(rows: _maxRowsPerRequest);
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest,
        after: _tweetCacheFetch.first.id,
      );
    }
  }

  TweetRequestOption _oldestRequestOption() {
    if (_tweetCacheFetch.length == 0) {
      return TweetRequestOption(rows: _maxRowsPerRequest);
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest,
        after: _tweetCacheFetch.last.id,
      );
    }
  }

  FeedCache _updateCache(TweetSessionEntity session) {
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.insertAll(0, session.tweets);
      } else {
        _tweetCacheFetch.insertAll(0, session.tweets.reversed);
      }
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _appendCache(TweetSessionEntity session) {
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.addAll(session.tweets);
      } else {
        _tweetCacheFetch.addAll(session.tweets.reversed);
      }
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }
}
