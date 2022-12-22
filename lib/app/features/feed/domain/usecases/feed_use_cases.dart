import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../entities/tweet_engage_request_option.dart';
import '../entities/tweet_entity.dart';
import '../entities/tweet_request_option.dart';
import '../entities/tweet_session_entity.dart';
import '../repositories/i_tweet_repositories.dart';
import 'tweet_filter_preference.dart';

@immutable
class FeedCache extends Equatable {
  const FeedCache({required this.tweets});

  final List<TweetTiles?> tweets;

  @override
  List<Object?> get props => [tweets];

  @override
  bool get stringify => true;
}

class FeedUseCases {
  FeedUseCases({
    required ITweetRepository repository,
    required TweetFilterPreference filterPreference,
    int? maxRows = 100,
  })  : _repository = repository,
        _filterPreference = filterPreference,
        _maxRowsPerRequest = maxRows;

  final ITweetRepository _repository;
  final TweetFilterPreference _filterPreference;
  final int? _maxRowsPerRequest;
  final StreamController<FeedCache> _streamController =
      StreamController.broadcast();

  Stream<FeedCache> get dataSource => _streamController.stream;
  List<TweetTiles?> _tweetCacheFetch = [];
  final Map<String?, List<TweetEntity?>> _tweetReplyMap = {};
  String? _nextPage;

  Future<Either<Failure, FeedCache>> fetchNewestTweet() async {
    final request = _newestRequestOption();
    final result = await _repository.fetch(option: request);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_updateFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> fetchOldestTweet() async {
    final request = _oldestRequestOption();
    final result = await _repository.fetch(option: request);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_appendFetchCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> reloadTweetFeed() async {
    _nextPage = null;
    _tweetCacheFetch = [];
    _streamController.add(FeedCache(tweets: _tweetCacheFetch));
    return fetchNewestTweet();
  }

  Future<Either<Failure, FeedCache>> fetchTweetDetail(String? tweetId) async {
    final option = _buildTweetDetailRequest(tweetId);
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_buildTweetDetail(session, tweetId)),
    );
  }

  Future<Either<Failure, FeedCache>> fetchNewestTweetDetail(
    String? tweetId,
  ) async {
    final option = _buildTweetDetailRequest(tweetId);
    final result = await _repository.fetch(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_buildTweetDetail(session, tweetId)),
    );
  }

  Future<Either<Failure, FeedCache>> create(String? content) async {
    final option = TweetCreateRequestOption(message: content);
    final result = await _repository.create(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_insertCreatedTweetIntoCache(session)),
    );
  }

  Future<Either<Failure, FeedCache>> delete(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id!);
    final result = await _repository.delete(option: option);

    return result.fold<Either<Failure, FeedCache>>(
      (failure) => left(failure),
      (session) => right(_deleteFetchCache(tweet)),
    );
  }

  Future<Either<Failure, FeedCache>> like(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id!);
    return _processTweetFavorite(option);
  }

  Future<Either<Failure, FeedCache>> unlike(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id!, dislike: true);
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

  Future<Either<Failure, TweetEntity>> reply({
    required TweetEntity mainTweet,
    required String? comment,
  }) async {
    final option = TweetEngageRequestOption(
      tweetId: mainTweet.id!,
      message: comment,
    );

    final result = await _repository.reply(option: option);

    return result.fold<Either<Failure, TweetEntity>>(
      (failure) => left(failure),
      (repliedTweet) {
        _updateRepliedTweetIntoCache(
          mainTweet,
          repliedTweet,
        );
        return right(repliedTweet);
      },
    );
  }

  Future<Either<Failure, ValidField>> report(
    TweetEntity tweet,
    String reason,
  ) async {
    final option =
        TweetEngageRequestOption(tweetId: tweet.id!, message: reason);
    final result = await _repository.report(option: option);

    return result.fold<Either<Failure, ValidField>>(
      (failure) => left(failure),
      (session) => right(session),
    );
  }

  TweetRequestOption _newestRequestOption() {
    final TweetEntity? firstValid = _tweetCacheFetch.isNotEmpty
        ? _tweetCacheFetch.firstWhere(
            (e) => e is TweetEntity,
            orElse: () => null,
          ) as TweetEntity?
        : null;

    final String? category = _getCategory();
    final String? tags = _getTags();

    if (firstValid == null) {
      return TweetRequestOption(
        rows: _maxRowsPerRequest!,
        category: category,
        tags: tags,
        after: (_tweetCacheFetch.isNotEmpty) ? '000000T0000000000' : null,
      );
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest!,
        after: firstValid.id,
        category: category,
        tags: tags,
      );
    }
  }

  String? _getTags() {
    final List<String> tags = _filterPreference.getTags();
    return tags.isEmpty ? null : tags.join(',');
  }

  String? _getCategory() {
    final List<String> category = _filterPreference.categories;
    return category.isEmpty ? null : category.join(',');
  }

  TweetRequestOption _oldestRequestOption() {
    final TweetEntity? lastValid = _tweetCacheFetch.isNotEmpty
        ? _tweetCacheFetch.lastWhere(
            (e) => e is TweetEntity,
            orElse: () => null,
          ) as TweetEntity?
        : null;

    final String? category = _getCategory();
    final String? tags = _getTags();

    if (lastValid == null) {
      return TweetRequestOption(
        rows: _maxRowsPerRequest!,
        nextPageToken: _nextPage,
        category: category,
        tags: tags,
      );
    } else {
      return TweetRequestOption(
        rows: _maxRowsPerRequest!,
        before: _nextPage == null ? lastValid.id : null,
        nextPageToken: _nextPage,
        category: category,
        tags: tags,
      );
    }
  }

  FeedCache _updateFetchCache(TweetSessionEntity session) {
    if (_nextPage == null || _nextPage!.isEmpty) {
      _nextPage = session.nextPage;
    }

    if (session.tweets.isNotEmpty) {
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
    if (session.tweets.isNotEmpty) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetCacheFetch.addAll(session.tweets);
      } else {
        _tweetCacheFetch.addAll(session.tweets.reversed);
      }
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  TweetEntity? _extractTweetEntity(int index) {
    if (index >= 0 && _tweetCacheFetch[index] is TweetEntity) {
      return _tweetCacheFetch[index] as TweetEntity?;
    }

    return null;
  }

  FeedCache _deleteFetchCache(TweetEntity tweet) {
    final index = _tweetCacheFetch.indexWhere(
      (e) {
        if (e is TweetEntity) {
          return (e.id == tweet.id) ||
              (e.lastReply!.isNotEmpty && e.lastReply!.first!.id == tweet.id);
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
              (e.lastReply!.isNotEmpty &&
                  e.lastReply!.first!.id == newTweet.id);
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
    } else if (currentTweet.lastReply!.isNotEmpty &&
        currentTweet.lastReply!.first!.id == newTweet.id) {
      // se a tweet for um reply, reconstrua o principal com o novo reply
      final reply = newTweet.copyWith(
        lastReply: currentTweet.lastReply!.first!.lastReply,
      );
      final princialTweet = currentTweet.copyWith(lastReply: [reply]);
      _tweetCacheFetch[index] = princialTweet;
    }

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  FeedCache _insertCreatedTweetIntoCache(TweetEntity tweet) {
    _tweetCacheFetch.insertAll(
      0,
      [tweet],
    );

    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  void _updateRepliedTweetIntoCache(
    TweetEntity mainTweet,
    TweetEntity repliedTweet,
  ) {
    final index = _tweetCacheFetch
        .indexWhere((e) => e is TweetEntity && e.id == mainTweet.id);

    if (index >= 0) {
      final TweetEntity rebuildedTweet = mainTweet.copyWith(
        totalReply: mainTweet.totalReply + 1,
        lastReply: [repliedTweet],
      );

      _tweetCacheFetch[index] = rebuildedTweet;
    }

    _updateStream();
  }

  void _updateStream() {
    _streamController.add(FeedCache(tweets: _tweetCacheFetch));
  }

  TweetRequestOption _buildTweetDetailRequest(String? tweetId) {
    String? afterTweetId = tweetId;
    if (_tweetReplyMap[tweetId] != null &&
        _tweetReplyMap[tweetId]!.isNotEmpty) {
      afterTweetId = _tweetReplyMap[tweetId]!.last!.id;
    }

    return TweetRequestOption(
      after: afterTweetId,
      parent: tweetId,
      rows: _maxRowsPerRequest!,
    );
  }

  FeedCache _buildTweetDetail(TweetSessionEntity session, String? tweetId) {
    if (_tweetReplyMap[tweetId] == null) {
      _tweetReplyMap[tweetId] = [];
    }

    final List<TweetEntity?> filteredResponse =
        session.tweets.whereType<TweetEntity>().toList();

    if (filteredResponse.isNotEmpty) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetReplyMap[tweetId]!.addAll(filteredResponse.reversed);
      } else {
        _tweetReplyMap[tweetId]!.addAll(filteredResponse);
      }
    }

    return FeedCache(
      tweets: [
        if (session.parent != null) session.parent,
        ..._tweetReplyMap[tweetId]!
      ],
    );
  }

  void dispose() {
    _streamController.close();
  }
}
