import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
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
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_updateFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> fetchOldestTweet() async {
    final option = _oldestRequestOption();
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_appendFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> create(String content) async {
    final option = TweetCreateRequestOption(message: content);
    final result = await _repository.create(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_insertCreatedTweetIntoCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> delete(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id);
    final result = await _repository.delete(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_deleteFetchCache(tweet)),
    );
  }

  Future<Either<Failure, FeedCache>> like(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id);
    final result = await _repository.like(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_rebuildFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> unlike(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id, dislike: true);
    final result = await _repository.like(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_rebuildFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> comment({
    @required TweetEntity mainTweet,
    @required String comment,
  }) async {
    throw UnimplementedError();
    // final result = await _repository.comment(option: option);

    // return result.fold<Either<Failure, FeedCache>>(
    //   (failure) => left(failure),
    //   (session) => right(_detailFetchCache(option)),
    // );
  }

  Future<Either<Failure, ValidField>> report(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id);
    final result = await _repository.report(option: option);

    return result.fold<Either<Failure, ValidField>>(
      (failure) => left(failure),
      (session) => right(session),
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

  FeedCache _updateFetchCache(TweetSessionEntity session) {
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.insertAll(0, session.tweets);
      } else {
        _tweetCacheFetch.insertAll(0, session.tweets.reversed);
      }
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _appendFetchCache(TweetSessionEntity session) {
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.addAll(session.tweets);
      } else {
        _tweetCacheFetch.addAll(session.tweets.reversed);
      }
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _deleteFetchCache(TweetEntity tweet) {
    _tweetCacheFetch.removeWhere(
      (e) => e.id == tweet.id,
    );

    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _rebuildFetchCache(TweetEntity newTweet) {
    final index = _tweetCacheFetch.indexWhere(
      (e) =>
          (e.id == newTweet.id) ||
          (e.lastReply.isNotEmpty && e.lastReply.first.id == newTweet.id),
    );

    if (index >= 0) {
      final currentTweet = _tweetCacheFetch[index];
      if (currentTweet.id == newTweet.id) {
        _tweetCacheFetch[index] = newTweet.copyWith(
          lastReply: currentTweet.lastReply,
        );
      }
      // se a tweet for um reply, reconstrua o principal com o novo reply
      else if (currentTweet.lastReply.isNotEmpty &&
          currentTweet.lastReply.first.id == newTweet.id) {
        final reply = newTweet.copyWith(
            lastReply: currentTweet.lastReply.first.lastReply);
        final princialTweet = currentTweet.copyWith(lastReply: [reply]);
        _tweetCacheFetch[index] = princialTweet;
      }
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }

  // TODO
  // Insere o tweet criado justo com uma marcação de gap entre o que existia
  // e o novo. Pretendo usar estar marcação para, no futuro, recriar o gap
  // de conteúdo entre eles
  FeedCache _insertCreatedTweetIntoCache(TweetEntity tweet) {
    if (tweet != null) {
      _tweetCacheFetch.insertAll(
        0,
        [tweet, TweetGap()],
      );
    }

    return FeedCache(tweets: _tweetCacheFetch);
  }
}
