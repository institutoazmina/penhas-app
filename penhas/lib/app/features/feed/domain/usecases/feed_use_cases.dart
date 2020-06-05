import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

class FeedUseCases {
  final ITweetRepository _repository;
  List<TweetEntity> _tweetList = List<TweetEntity>();

  FeedUseCases({
    @required ITweetRepository repository,
  })  : assert(repository != null),
        _repository = repository;
}
