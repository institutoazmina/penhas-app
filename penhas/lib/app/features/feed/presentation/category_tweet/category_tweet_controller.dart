import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'category_tweet_controller.g.dart';

class CategoryTweetController extends _CategoryTweetControllerBase
    with _$CategoryTweetController {
  CategoryTweetController({
    @required FeedUseCases useCase,
    @required TweetEntity tweet,
  }) : super(useCase, tweet);
}

abstract class _CategoryTweetControllerBase with Store, MapFailureMessage {
  final TweetEntity tweet;
  final FeedUseCases useCase;
  String tweetContent;

  _CategoryTweetControllerBase(this.useCase, this.tweet) {
    listTweets = ObservableList.of([tweet]);
  }

  @observable
  ObservableFuture<Either<Failure, FeedCache>> _progress;

  @observable
  ObservableList<TweetEntity> listTweets = ObservableList<TweetEntity>();

  @observable
  bool isAnonymousMode = false;

  @observable
  bool isEnableCreateButton = false;

  @observable
  TextEditingController editingController = TextEditingController();

  @observable
  String errorMessage = '';

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> getDetail() async {
    _progress = ObservableFuture(useCase.fetchTweetDetail(tweet));

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (cache) => _updateListOfTweets(cache),
    );
  }

  @action
  Future<void> fetchNextPage() async {
    _progress = ObservableFuture(useCase.fetchNewestTweetDetail(tweet));

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (cache) => _updateListOfTweets(cache),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _updateListOfTweets(FeedCache cache) {
    List<TweetEntity> tweets =
        cache.tweets.where((e) => e is TweetEntity).toList();
    tweets.insert(0, tweet);
    listTweets = tweets.asObservable();
  }
}
