import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

enum TweetSessionOrder { latestFirst, oldestFirst }

class TweetSessionEntity extends Equatable {
  final bool hasMore;
  final TweetSessionOrder orderBy;
  final List<TweetTiles> tweets;

  TweetSessionEntity({
    @required this.hasMore,
    @required this.orderBy,
    @required this.tweets,
  });

  @override
  List<Object> get props => [hasMore, orderBy, tweets];

  @override
  String toString() {
    return 'TweetSessionEntity{hasMore: ${hasMore.toString()}, orderBy: ${orderBy.toString()}, tweets: ${tweets.toString()}}';
  }
}
