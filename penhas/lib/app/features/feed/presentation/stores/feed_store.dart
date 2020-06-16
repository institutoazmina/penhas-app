import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'feed_store.g.dart';

class FeedStore extends _FeedStoreBase with _$FeedStore {
  FeedStore({
    @required FeedUseCases useCase,
  }) : super(useCase);
}

abstract class _FeedStoreBase with Store {
  final FeedUseCases useCase;

  _FeedStoreBase(this.useCase);

  void createTweet(String content) {}
}
