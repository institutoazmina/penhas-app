import 'dart:async';
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
  final List<TweetTiles> tweets;

  FeedCache({@required this.tweets});

  @override
  List<Object> get props => [tweets];

  @override
  bool get stringify => true;
}

class FeedUseCases {
  final ITweetRepository _repository;
  final int _maxRowsPerRequest;
  final StreamController<FeedCache> _streamController =
      StreamController.broadcast();

  Stream<FeedCache> get dataSource => _streamController.stream;
  List<TweetTiles> _tweetCacheFetch = List<TweetTiles>();
  Map<String, List<TweetEntity>> _tweetReplyMap = {};
  String _nextPage = '';

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

  Future<Either<Failure, FeedCache>> fetchTweetDetail(TweetEntity tweet) async {
    final option = _buildTweetDetailRequest(tweet);
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_buildTweetDetail(session, tweet)),
    );
  }

  Future<Either<Failure, FeedCache>> fetchNewestTweetDetail(
      TweetEntity tweet) async {
    final option = _buildTweetDetailRequest(tweet);
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_buildTweetDetail(session, tweet)),
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
    return _processTweetFavorite(option);
  }

  Future<Either<Failure, FeedCache>> unlike(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id, dislike: true);
    return _processTweetFavorite(option);
  }

  Future<Either<Failure, FeedCache>> _processTweetFavorite(
    TweetEngageRequestOption option,
  ) async {
    final result = await _repository.like(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_rebuildFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> reply({
    @required TweetEntity mainTweet,
    @required String comment,
  }) async {
    final option = TweetEngageRequestOption(
      tweetId: mainTweet.id,
      message: comment,
    );

    final result = await _repository.reply(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (repliedTweet) => right(
        _updateRepliedTweetIntoCache(
          mainTweet,
          repliedTweet,
        ),
      ),
    );
  }

  Future<Either<Failure, ValidField>> report(
    TweetEntity tweet,
    String reason,
  ) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id, message: reason);
    final result = await _repository.report(option: option);

    return result.fold<Either<Failure, ValidField>>(
      (failure) => left(failure),
      (session) => right(session),
    );
  }

  TweetRequestOption _newestRequestOption() {
    final TweetEntity firstValid = _tweetCacheFetch.length > 0
        ? _tweetCacheFetch.firstWhere((e) => e is TweetEntity)
        : null;

    if (firstValid == null) {
      return TweetRequestOption(rows: _maxRowsPerRequest);
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest,
        after: firstValid.id,
      );
    }
  }

  TweetRequestOption _oldestRequestOption() {
    final TweetEntity lastValid = _tweetCacheFetch.length > 0
        ? _tweetCacheFetch.lastWhere((e) => e is TweetEntity)
        : null;

    if (lastValid == null) {
      return TweetRequestOption(rows: _maxRowsPerRequest);
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest,
        before: _nextPage == null ? lastValid.id : null,
        nextPageToken: _nextPage,
      );
    }
  }

  FeedCache _updateFetchCache(TweetSessionEntity session) {
    _nextPage = session.nextPage;
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.insertAll(0, session.tweets);
      } else {
        _tweetCacheFetch.insertAll(0, session.tweets.reversed);
      }
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _appendFetchCache(TweetSessionEntity session) {
    _nextPage = session.nextPage;
    if (session.tweets != null && session.tweets.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.addAll(session.tweets);
      } else {
        _tweetCacheFetch.addAll(session.tweets.reversed);
      }
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  TweetEntity _extractTweetEntity(int index) {
    if (index >= 0 && _tweetCacheFetch[index] is TweetEntity) {
      return _tweetCacheFetch[index];
    }

    return null;
  }

  FeedCache _deleteFetchCache(TweetEntity tweet) {
    final index = _tweetCacheFetch.indexWhere(
      (e) {
        if (e is TweetEntity) {
          return (e.id == tweet.id) ||
              (e.lastReply.isNotEmpty && e.lastReply.first.id == tweet.id);
        }
        return false;
      },
    );

    final currentTweet = _extractTweetEntity(index);
    if (currentTweet == null) {
      return FeedCache(tweets: _tweetCacheFetch);
    }

    if (currentTweet.id == tweet.id) {
      _tweetCacheFetch.removeAt(index);
    } else {
      _tweetCacheFetch[index] = currentTweet.copyWith(
        lastReply: [],
        totalReply: currentTweet.totalReply - 1,
      );
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _rebuildFetchCache(TweetEntity newTweet) {
    final index = _tweetCacheFetch.indexWhere(
      (e) {
        if (e is TweetEntity) {
          return (e.id == newTweet.id) ||
              (e.lastReply.isNotEmpty && e.lastReply.first.id == newTweet.id);
        }
        return false;
      },
    );

    final currentTweet = _extractTweetEntity(index);
    if (currentTweet == null) {
      return FeedCache(tweets: _tweetCacheFetch);
    }

    if (currentTweet.id == newTweet.id) {
      _tweetCacheFetch[index] = newTweet.copyWith(
        lastReply: currentTweet.lastReply,
      );
    } else if (currentTweet.lastReply.isNotEmpty &&
        currentTweet.lastReply.first.id == newTweet.id) {
      // se a tweet for um reply, reconstrua o principal com o novo reply
      final reply =
          newTweet.copyWith(lastReply: currentTweet.lastReply.first.lastReply);
      final princialTweet = currentTweet.copyWith(lastReply: [reply]);
      _tweetCacheFetch[index] = princialTweet;
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _insertCreatedTweetIntoCache(TweetEntity tweet) {
    if (tweet != null) {
      _tweetCacheFetch.insertAll(
        0,
        [tweet],
      );
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _updateRepliedTweetIntoCache(
      TweetEntity mainTweet, TweetEntity repliedTweet) {
    final index = _tweetCacheFetch
        .indexWhere((e) => (e is TweetEntity && e.id == mainTweet.id));

    if (index >= 0) {
      TweetEntity rebuildedTweet = mainTweet.copyWith(
        totalReply: mainTweet.totalReply + 1,
        lastReply: [repliedTweet],
      );

      _tweetCacheFetch[index] = rebuildedTweet;
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  _updateStream() {
    _streamController.add(FeedCache(tweets: _tweetCacheFetch));
  }

  TweetRequestOption _buildTweetDetailRequest(TweetEntity tweet) {
    String afterTweetId = tweet.id;
    if (_tweetReplyMap[tweet.id] != null &&
        _tweetReplyMap[tweet.id].isNotEmpty) {
      afterTweetId = _tweetReplyMap[tweet.id].last.id;
    }

    return TweetRequestOption(
      after: afterTweetId,
      parent: tweet.id,
      rows: _maxRowsPerRequest,
    );
  }

  FeedCache _buildTweetDetail(TweetSessionEntity session, TweetEntity tweet) {
    if (_tweetReplyMap[tweet.id] == null) {
      _tweetReplyMap[tweet.id] = [];
    }

    final List<TweetEntity> filteredResponse = session.tweets
        .map((e) => e is TweetEntity ? e : null)
        .where((e) => e != null)
        .toList();

    if (filteredResponse != null && filteredResponse.length > 0) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetReplyMap[tweet.id].addAll(filteredResponse.reversed);
      } else {
        _tweetReplyMap[tweet.id].addAll(filteredResponse);
      }
    }

    return FeedCache(tweets: _tweetReplyMap[tweet.id]);
  }

  void dispose() {
    _streamController.close();
  }
}
