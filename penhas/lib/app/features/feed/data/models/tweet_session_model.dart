import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

class TweetSessionMondel extends TweetSessionEntity {
  final bool hasMore;
  final TweetSessionOrder orderBy;
  final List<TweetEntity> tweets;

  TweetSessionMondel(this.hasMore, this.orderBy, this.tweets)
      : super(hasMore: hasMore, orderBy: orderBy, tweets: tweets);

  factory TweetSessionMondel.fromJson(Map<String, Object> jsonData) {
    final hasMore = jsonData['has_more'] == 1 ?? false;
    final orderBy = jsonData['order_by'] == 'latest_first'
        ? TweetSessionOrder.latestFirst
        : TweetSessionOrder.oldestFirst;
    final tweets = _parseTweet(jsonData['tweets']);

    return TweetSessionMondel(hasMore, orderBy, tweets);
  }

  static List<TweetEntity> _parseTweet(List<Object> tweets) {
    if (tweets == null || tweets.isEmpty) {
      return [];
    }

    return tweets
        .map((e) => e as Map<String, Object>)
        .map((e) => _mapToTweet(e))
        .toList();
  }

  static TweetEntity _mapToTweet(Map<String, Object> data) {
    final meta = data['meta'] as Map<String, Object>;
    final tweetMeta = TweetMeta(
      liked: meta['liked'] == 1 ?? false,
      owner: meta['owner'] == 1 ?? false,
    );

    return TweetEntity(
      id: data['id'],
      userName: data['name'],
      createdAt: data['created_at'],
      clientId: (data['cliente_id'] as num).toInt(),
      totalLikes: (data['qtde_likes'] as num).toInt(),
      totalReply: (data['qtde_comentarios'] as num).toInt(),
      anonymous: data['anonimo'] != 0,
      content: data['content'],
      avatar: data['icon'],
      meta: tweetMeta,
    );
  }
}
