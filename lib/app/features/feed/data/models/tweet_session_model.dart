import 'package:collection/collection.dart';
import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

class TweetSessionModel extends TweetSessionEntity {
  const TweetSessionModel(
    TweetSessionOrder orderBy,
    TweetTiles? parent,
    List<TweetTiles> tweets,
    String? nextPage, {
    required bool hasMore,
  }) : super(
          hasMore: hasMore,
          orderBy: orderBy,
          parent: parent,
          tweets: tweets,
          nextPage: nextPage,
        );

  factory TweetSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final hasMore = jsonData['has_more'] == 1;
    final nextPage = jsonData['next_page'];
    final orderBy = jsonData['order_by'] == 'latest_first'
        ? TweetSessionOrder.latestFirst
        : TweetSessionOrder.oldestFirst;
    final parent = jsonData['parent'] != null
        ? _parseJson(jsonData['parent'] as Map<String, dynamic>)
        : null;
    final tweets = _parseTweet(jsonData['tweets']);

    return TweetSessionModel(
      orderBy,
      parent,
      tweets,
      nextPage,
      hasMore: hasMore,
    );
  }

  static List<TweetTiles> _parseTweet(List<dynamic>? tweets) {
    if (tweets == null || tweets.isEmpty) {
      return [];
    }

    return tweets
        .map((e) => e as Map<String, dynamic>)
        .map(_parseJson)
        .whereNotNull()
        .toList();
  }

  static TweetTiles? _parseJson(Map<String, dynamic> json) {
    if (json['type'] == 'tweet') {
      return TweetModel.fromJson(json);
    }

    if (json['type'] == 'related_news') {
      return TweetRelatedNewsModel.fromJson(json);
    }

    if (json['type'] == 'news') {
      return TweetNewsModel.fromJson(json);
    }

    if (json['type'] == 'news_group') {
      return TweetNewsGroupModel.fromJson(json);
    }

    return null;
  }
}
