import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';

class TweetSessionMondel extends TweetSessionEntity {
  final bool hasMore;
  final TweetSessionOrder orderBy;
  final List<TweetEntity> tweets;

  TweetSessionMondel(this.hasMore, this.orderBy, this.tweets)
      : super(hasMore: hasMore, orderBy: orderBy, tweets: tweets);
}
