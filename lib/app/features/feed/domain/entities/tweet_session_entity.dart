import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';

enum TweetSessionOrder { latestFirst, oldestFirst }

class TweetSessionEntity extends Equatable {
  const TweetSessionEntity({
    required this.hasMore,
    required this.orderBy,
    this.parent,
    required this.tweets,
    required this.nextPage,
  });

  final bool hasMore;
  final TweetSessionOrder orderBy;
  final String? nextPage;
  final TweetTiles? parent;
  final List<TweetTiles> tweets;

  @override
  List<Object?> get props => [hasMore, orderBy, parent, tweets, nextPage];
}
