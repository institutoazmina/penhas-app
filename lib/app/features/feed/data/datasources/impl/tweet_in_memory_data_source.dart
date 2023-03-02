import 'dart:async';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/tweet_entity.dart';
import '../../../domain/error/tweet_removed_error.dart';
import '../tweet_data_source.dart';

typedef TweetListCache = List<TweetTiles>;
typedef TweetRepliesCache = Map<String, List<TweetEntity>>;

class TweetInMemoryDataSource implements ITweetLocalDataSource {
  factory TweetInMemoryDataSource() =>
      TweetInMemoryDataSource.withInitialData();

  @visibleForTesting
  TweetInMemoryDataSource.withInitialData({
    TweetListCache? tweetListCache,
    TweetRepliesCache? relatedTweetsCache,
  })  : _tweetListCache = tweetListCache ?? [],
        _relatedTweetsCache = relatedTweetsCache ?? {};

  final TweetListCache _tweetListCache;
  final TweetRepliesCache _relatedTweetsCache;

  late final Subject<TweetListCache> _listStreamCtrl = BehaviorSubject()
    ..add(_tweetListCache);

  late final Subject<TweetRepliesCache> _relatedTweetsStreamCtrl =
      BehaviorSubject()..add(_relatedTweetsCache);

  @override
  Stream<List<TweetTiles>> getTweets() => _listStreamCtrl.stream.distinct();

  @override
  Stream<List<TweetEntity>> getRelatedTweets(String id) {
    _relatedTweetsCache.putIfAbsent(id, () {
      final tweet = _findInTweetsCache(id, searchInLastReply: false) ??
          _findInRelatedTweetCache(id).firstOrNull;
      return tweet != null ? [tweet.item] : [];
    });

    return _relatedTweetsStreamCtrl.stream
        .doOnCancel(() => _relatedTweetsCache.remove(id))
        .map(
      (cache) {
        if (!cache.containsKey(id)) throw TweetRemovedError();
        return cache[id]!;
      },
    ).distinct();
  }

  @override
  void update(TweetEntity tweet) {
    _replaceInCache(tweet);
  }

  @override
  void remove(TweetEntity tweet) {
    _removeFromCache(tweet);
  }

  @override
  void replaceAll(List<TweetTiles> tweets) {
    _tweetListCache.clear();
    append(tweets);
  }

  @override
  void prepend(List<TweetTiles> tweets) {
    _tweetListCache.insertAll(0, tweets);
    _listStreamCtrl.add(_tweetListCache);
  }

  @override
  void append(List<TweetTiles> tweets, {String? parentId}) {
    if (parentId == null) {
      _tweetListCache.addAll(tweets);
      _listStreamCtrl.add(_tweetListCache);
    } else {
      _relatedTweetsCache[parentId]?.addAll(tweets.whereType<TweetEntity>());
      _relatedTweetsStreamCtrl.add(_relatedTweetsCache);
    }
  }

  void _replaceInCache(TweetEntity tweet) {
    _findInCache(tweet.id).forEach(
      (e) => _updateEntryCache(
        e.copyWith(
          item: tweet.lastReply.isNotEmpty
              ? tweet
              : tweet.copyWith(lastReply: e.item.lastReply),
        ),
      ),
    );
  }

  void _removeFromCache(TweetEntity tweet) {
    _findInCache(tweet.id).forEach(_removeEntryFromCache);

    if (tweet.parentId != null) {
      _findInRelatedTweetCache(tweet.parentId!).forEach(
        (e) {
          final item = e.item;
          final totalReply = item.totalReply > 0 ? item.totalReply - 1 : 0;
          return _updateEntryCache(
            e.copyWith(item: item.copyWith(totalReply: totalReply)),
          );
        },
      );
    }
  }

  void _updateEntryCache(_TweetEntry entry) {
    switch (entry.type) {
      case _TweetEntryType.feed:
        _tweetListCache[entry.index] = entry.item;
        _listStreamCtrl.add(_tweetListCache);
        break;
      case _TweetEntryType.lastReply:
        final tweet = _tweetListCache[entry.key] as TweetEntity;
        _tweetListCache[entry.key] = tweet.copyWith(
          lastReply: tweet.lastReply
              .mapIndexed((index, e) => index == entry.index ? entry.item : e)
              .toList(),
        );
        _listStreamCtrl.add(_tweetListCache);
        break;
      case _TweetEntryType.detail:
        _relatedTweetsCache[entry.key]![entry.index] = entry.item;
        _relatedTweetsStreamCtrl.add(_relatedTweetsCache);
        break;
    }
  }

  void _removeEntryFromCache(_TweetEntry entry) {
    switch (entry.type) {
      case _TweetEntryType.feed:
        _tweetListCache.removeAt(entry.index);
        _listStreamCtrl.add(_tweetListCache);
        break;
      case _TweetEntryType.lastReply:
        final tweet = _tweetListCache[entry.key] as TweetEntity;
        _tweetListCache[entry.key] = tweet.copyWith(
          lastReply: tweet.lastReply
              .whereNotIndexed((index, _) => index == entry.index)
              .toList(),
          totalReply: tweet.totalReply - 1,
        );
        _listStreamCtrl.add(_tweetListCache);
        break;
      case _TweetEntryType.detail:
        _relatedTweetsCache[entry.key]!.removeAt(entry.index);
        _relatedTweetsStreamCtrl.add(_relatedTweetsCache);
        break;
    }
  }

  Iterable<_TweetEntry> _findInCache(String tweetId) => [
        _findInTweetsCache(tweetId),
        ..._findInRelatedTweetCache(tweetId),
      ].whereNotNull();

  _TweetEntry? _findInTweetsCache(
    String tweetId, {
    bool searchInLastReply = true,
  }) {
    int index = _tweetListCache.indexWhere(
      (tweet) => _hasTweet(
        tweet,
        tweetId,
        searchInLastReply: searchInLastReply,
      ),
    );

    if (index == -1) return null;

    final item = _tweetListCache[index] as TweetEntity;
    if (item.id == tweetId) return _TweetEntry.feed(index, item);

    final key = index;
    index = item.lastReply.indexWhere((e) => e.id == tweetId);
    return index != -1
        ? _TweetEntry.lastReply(index, key, item.lastReply[index])
        : null;
  }

  Iterable<_TweetEntry> _findInRelatedTweetCache(String tweetId) sync* {
    int index = -1;

    for (final entry in _relatedTweetsCache.entries) {
      index = entry.value.indexWhere((e) => e.id == tweetId);
      if (index >= 0) {
        yield _TweetEntry.detail(index, entry.key, entry.value[index]);
      }
    }
  }

  bool _hasTweet(
    TweetTiles tweet,
    String id, {
    bool searchInLastReply = true,
  }) {
    if (tweet is! TweetEntity) return false;

    if (tweet.id == id) return true;

    if (searchInLastReply) {
      return tweet.lastReply.firstWhereOrNull((r) => r.id == id) != null;
    }

    return false;
  }
}

class _TweetEntry {
  const _TweetEntry(this.index, this.key, this.item, this.type);

  factory _TweetEntry.feed(int index, TweetEntity item) =>
      _TweetEntry(index, item.id, item, _TweetEntryType.feed);

  factory _TweetEntry.detail(int index, String key, TweetEntity item) =>
      _TweetEntry(index, key, item, _TweetEntryType.detail);

  factory _TweetEntry.lastReply(int index, int key, TweetEntity item) =>
      _TweetEntry(index, key, item, _TweetEntryType.lastReply);

  final int index;
  final dynamic key;
  final TweetEntity item;
  final _TweetEntryType type;

  _TweetEntry copyWith({required TweetEntity item}) =>
      _TweetEntry(index, key, item, type);
}

enum _TweetEntryType { feed, detail, lastReply }
