import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

enum TweetSessionOrder { latestFirst, oldestFirst }

class TweetSessionEntity extends Equatable {
  final bool hasMore;
  final TweetSessionOrder orderBy;
  final String nextPage;
  final List<TweetTiles> tweets;

  TweetSessionEntity({
    @required this.hasMore,
    @required this.orderBy,
    @required this.tweets,
    @required this.nextPage,
  });

  @override
  List<Object> get props => [hasMore, orderBy, tweets, nextPage];

  @override
  String toString() {
    return 'TweetSessionEntity{hasMore: ${hasMore.toString()}, orderBy: ${orderBy.toString()}, nextPage: ${nextPage.toString()}, tweets: ${tweets.toString()}}';
  }
}
