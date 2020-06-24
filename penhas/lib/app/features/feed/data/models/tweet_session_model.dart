import 'package:penhas/app/features/feed/data/models/tweet_model.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

class TweetSessionModel extends TweetSessionEntity {
  final bool hasMore;
  final String nextPage;
  final TweetSessionOrder orderBy;
  final List<TweetTiles> tweets;

  TweetSessionModel(
    this.hasMore,
    this.orderBy,
    this.tweets,
    this.nextPage,
  ) : super(
          hasMore: hasMore,
          orderBy: orderBy,
          tweets: tweets,
          nextPage: nextPage,
        );

  factory TweetSessionModel.fromJson(Map<String, Object> jsonData) {
    final hasMore = jsonData['has_more'] == 1 ?? false;
    final nextPage = jsonData['next_page'];
    final orderBy = jsonData['order_by'] == 'latest_first'
        ? TweetSessionOrder.latestFirst
        : TweetSessionOrder.oldestFirst;
    final tweets = _parseTweet(jsonData['tweets']);

    return TweetSessionModel(hasMore, orderBy, tweets, nextPage);
  }

  static List<TweetTiles> _parseTweet(List<Object> tweets) {
    if (tweets == null || tweets.isEmpty) {
      return [];
    }

    return tweets
        .map((e) => e as Map<String, Object>)
        .map((e) => _parseJson(e))
        .where((e) => e != null)
        .toList();
  }

  static TweetTiles _parseJson(Map<String, Object> json) {
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
