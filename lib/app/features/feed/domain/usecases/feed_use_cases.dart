import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/extension/list.dart';
import '../entities/tweet_engage_request_option.dart';
import '../entities/tweet_entity.dart';
import '../entities/tweet_request_option.dart';
import '../entities/tweet_session_entity.dart';
import '../error/tweet_removed_error.dart';
import '../repositories/i_tweet_repositories.dart';
import 'tweet_filter_preference.dart';

typedef _TweetDetail = Map<String, List<TweetEntity>>;

@immutable
class FeedCache extends Equatable {
  const FeedCache({required this.tweets});

  final List<TweetTiles> tweets;

  @override
  List<Object?> get props => [tweets];

  @override
  bool get stringify => true;
}

class FeedUseCases {
  FeedUseCases({
    required ITweetRepository repository,
    required TweetFilterPreference filterPreference,
    int maxRows = 100,
  })  : _repository = repository,
        _filterPreference = filterPreference,
        _maxRowsPerRequest = maxRows;

  final ITweetRepository _repository;
  final TweetFilterPreference _filterPreference;
  final int _maxRowsPerRequest;
  String? _nextPage;

  List<TweetTiles> _tweetCacheFetch = [];
  final _TweetDetail _tweetReplyMap = {};

  final StreamController<FeedCache> _tweetListStreamCtrl = BehaviorSubject();

  final StreamController<_TweetDetail> _tweetDetailsStreamCtrl =
      BehaviorSubject();

  Stream<FeedCache> tweetList() => _tweetListStreamCtrl.stream;

  Stream<Either<Failure, FeedCache>> tweetDetail(String id) {
    _tweetReplyMap.putIfAbsent(id, () {
      final tweet = _findInTweetsCache(id);
      return [if (tweet != null) tweet];
    });

    return _tweetDetailsStreamCtrl.stream
        .doOnCancel(() => _tweetReplyMap.remove(id))
        .map<Either<Failure, FeedCache>>(
          (cache) => cache.containsKey(id)
              ? right(FeedCache(tweets: cache[id]!.sublist(0)))
              : left(TweetRemovedError()),
        )
        .distinct();
  }

  Future<Either<Failure, FeedCache>> fetchNewestTweet() async {
    final request = _newestRequestOption();
    final result = await _repository.fetch(option: request);

    return result.map(_prependFetchCache);
  }

  Future<Either<Failure, FeedCache>> fetchOldestTweet() async {
    final request = _oldestRequestOption();
    final result = await _repository.fetch(option: request);

    return result.map(_appendFetchCache);
  }

  Future<Either<Failure, FeedCache>> reloadTweetFeed() async {
    _nextPage = null;
    _tweetListStreamCtrl.add(FeedCache(tweets: _tweetCacheFetch = []));
    return fetchNewestTweet();
  }

  Future<Either<Failure, FeedCache>> fetchTweetDetail(String tweetId) async {
    final option = _buildTweetDetailRequest(tweetId);
    final result = await _repository.fetch(option: option);

    return result.map(
      (session) => _buildTweetDetail(session, tweetId),
    );
  }

  Future<Either<Failure, FeedCache>> fetchNewestTweetDetail(String tweetId) =>
      fetchTweetDetail(tweetId);

  Future<Either<Failure, FeedCache>> create(String? content) async {
    final option = TweetCreateRequestOption(message: content);
    final result = await _repository.create(option: option);

    return result.map(_insertCreatedTweetIntoCache);
  }

  Future<Either<Failure, FeedCache>> delete(TweetEntity tweet) async {
    final option = TweetEngageRequestOption(tweetId: tweet.id);
    final result = await _repository.delete(option: option);

    return result.map((session) {
      _removeFromCache(tweet);
      return FeedCache(tweets: _tweetCacheFetch);
    });
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

    return result.map((tweet) {
      _replaceInCache(tweet);
      return FeedCache(tweets: _tweetCacheFetch);
    });
  }

  Future<Either<Failure, TweetEntity>> reply({
    required TweetEntity mainTweet,
    required String? comment,
  }) async {
    final option = TweetEngageRequestOption(
      tweetId: mainTweet.id,
      message: comment,
    );

    final result = await _repository.reply(option: option);

    return result.map(
      (repliedTweet) {
        _updateRepliedTweetIntoCache(mainTweet, repliedTweet);
        return repliedTweet;
      },
    );
  }

  Future<Either<Failure, ValidField>> report(TweetEntity tweet, String reason) {
    final option = TweetEngageRequestOption(tweetId: tweet.id, message: reason);
    return _repository.report(option: option);
  }

  String? _getTags() {
    final List<String> tags = _filterPreference.getTags();
    return tags.isEmpty ? null : tags.join(',');
  }

  String? _getCategory() {
    final List<String> category = _filterPreference.categories;
    return category.isEmpty ? null : category.join(',');
  }

  TweetRequestOption _newestRequestOption() {
    final firstValid = _tweetCacheFetch.firstWhereOrNull(
      (e) => e is TweetEntity,
    ) as TweetEntity?;

    return TweetRequestOption(
      rows: _maxRowsPerRequest,
      category: _getCategory(),
      tags: _getTags(),
      after: firstValid == null && _tweetCacheFetch.isNotEmpty
          ? '000000T0000000000'
          : firstValid?.id,
    );
  }

  TweetRequestOption _oldestRequestOption() {
    final lastValid = _tweetCacheFetch.lastWhereOrNull(
      (e) => e is TweetEntity,
    ) as TweetEntity?;

    return TweetRequestOption(
      rows: _maxRowsPerRequest,
      before: _nextPage == null ? lastValid?.id : null,
      nextPageToken: _nextPage,
      category: _getCategory(),
      tags: _getTags(),
    );
  }

  FeedCache _prependFetchCache(TweetSessionEntity session) {
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

  FeedCache _insertCreatedTweetIntoCache(TweetEntity tweet) {
    _tweetCacheFetch.insertAll(0, [tweet]);
    _updateStream();
    return FeedCache(tweets: _tweetCacheFetch);
  }

  void _updateRepliedTweetIntoCache(
    TweetEntity mainTweet,
    TweetEntity repliedTweet,
  ) {
    _tweetReplyMap[mainTweet.id]?.add(repliedTweet);
    _replaceInCache(
      mainTweet.copyWith(
        totalReply: mainTweet.totalReply + 1,
        lastReply: [repliedTweet],
      ),
    );
  }

  void _updateStream() =>
      _tweetListStreamCtrl.add(FeedCache(tweets: _tweetCacheFetch));

  TweetRequestOption _buildTweetDetailRequest(String tweetId) {
    final afterTweetId = _tweetReplyMap[tweetId]?.lastOrNull?.id ?? tweetId;

    return TweetRequestOption(
      after: afterTweetId,
      parent: tweetId,
      rows: _maxRowsPerRequest,
    );
  }

  FeedCache _buildTweetDetail(TweetSessionEntity session, String tweetId) {
    final parent = session.parent as TweetEntity?;
    if (parent != null) {
      _replaceInCache(parent);
    }
    _tweetReplyMap[tweetId] ??= [if (parent != null) parent];

    final filteredResponse = session.tweets.whereType<TweetEntity>().toList();

    if (filteredResponse.isNotEmpty) {
      if (session.orderBy == TweetSessionOrder.latestFirst) {
        _tweetReplyMap[tweetId]!.addAll(filteredResponse.reversed);
      } else {
        _tweetReplyMap[tweetId]!.addAll(filteredResponse);
      }
    }

    _tweetDetailsStreamCtrl.add(_tweetReplyMap);

    return FeedCache(tweets: _tweetReplyMap[tweetId]!);
  }

  void _replaceInCache(TweetEntity tweet) {
    _updateInFeedCache(tweet);
    _updateInLastReply(tweet);
    _updateInReplyMap(tweet);
  }

  void _removeFromCache(TweetEntity tweet) {
    _removeFromFeedCache(tweet);
    _removeFromLastReply(tweet);
    _removeFromReplyMap(tweet);
  }

  void _updateInFeedCache(TweetEntity tweet) {
    if (tweet.parentId != null) return;

    final isUpdated = _tweetCacheFetch.updateFirstWhere(
      (item) => item is TweetEntity && item.id == tweet.id,
      (item) => tweet.copyWith(
        lastReply: tweet.lastReply.isNotEmpty
            ? tweet.lastReply
            : (item as TweetEntity).lastReply,
      ),
    );

    if (isUpdated) _updateStream();
  }

  void _removeFromFeedCache(TweetEntity tweet) {
    if (tweet.parentId != null) return;

    final isUpdated = _tweetCacheFetch.removeFirstWhere(
      (item) => item is TweetEntity && item.id == tweet.id,
    );

    if (isUpdated) _updateStream();
  }

  void _updateInLastReply(TweetEntity tweet) {
    if (tweet.parentId == null) return;

    final isUpdated = _tweetCacheFetch.updateFirstWhere(
      (item) =>
          item is TweetEntity &&
          item.lastReply.firstWhereOrNull((r) => r.id == tweet.id) != null,
      (item) => (item as TweetEntity).copyWith(
        lastReply:
            item.lastReply.map((e) => e.id == tweet.id ? tweet : e).toList(),
      ),
    );

    if (isUpdated) _updateStream();
  }

  void _removeFromLastReply(TweetEntity tweet) {
    if (tweet.parentId == null) return;

    final isUpdated = _tweetCacheFetch.updateFirstWhere(
      (item) =>
          item is TweetEntity &&
          item.lastReply.firstWhereOrNull((r) => r.id == tweet.id) != null,
      (item) => (item as TweetEntity).copyWith(
        totalReply: item.totalReply - 1,
        lastReply: item.lastReply.whereNot((e) => e.id == tweet.id).toList(),
      ),
    );

    if (isUpdated) _updateStream();
  }

  void _updateInReplyMap(TweetEntity tweet) {
    if (!_tweetReplyMap.containsKey(tweet.id) &&
        !_tweetReplyMap.containsKey(tweet.parentId)) return;

    final isUpdated = _tweetReplyMap.entries.fold<bool>(
      false,
      (previous, current) =>
          current.value.updateFirstWhere(
            (item) => item.id == tweet.id,
            (item) => tweet,
          ) ||
          previous,
    );

    if (isUpdated) _tweetDetailsStreamCtrl.add(_tweetReplyMap);
  }

  void _removeFromReplyMap(TweetEntity tweet) {
    var isUpdated = false;
    if (_tweetReplyMap.containsKey(tweet.parentId)) {
      isUpdated = _tweetReplyMap[tweet.parentId]!.removeFirstWhere(
        (item) => item.id == tweet.id,
      );

      var parent = _tweetReplyMap[tweet.parentId]!.first;
      if (parent.id == tweet.parentId) {
        parent = parent.copyWith(totalReply: parent.totalReply - 1);
        _replaceInCache(parent);
      }
    }

    if (_tweetReplyMap.containsKey(tweet.id)) {
      _tweetReplyMap.remove(tweet.id);
      isUpdated = true;
    }

    if (isUpdated) _tweetDetailsStreamCtrl.add(_tweetReplyMap);
  }

  TweetEntity? _findInTweetsCache(String id) {
    return _tweetCacheFetch
            .whereType<TweetEntity>()
            .firstWhereOrNull((e) => e.id == id) ??
        _tweetReplyMap.values
            .expand((e) => e)
            .firstWhereOrNull((e) => e.id == id);
  }
}
