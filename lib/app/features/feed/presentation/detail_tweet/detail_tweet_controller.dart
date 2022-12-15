import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'detail_tweet_controller.g.dart';

const int invalidPosition = -1;

class DetailTweetController extends _DetailTweetControllerBase
    with _$DetailTweetController {
  DetailTweetController({
    required FeedUseCases useCase,
    TweetEntity? tweet,
    String? tweetId,
    String? commentId,
  }) : super(useCase, tweet, tweetId ?? tweet!.id, commentId);
}

abstract class _DetailTweetControllerBase with Store, MapFailureMessage {
  _DetailTweetControllerBase(
    this.useCase,
    TweetEntity? tweet,
    this.tweetId,
    this.commentId,
  ) : isWithoutGoToParentAction = tweet != null {
    listTweets = ObservableList.of([if (tweet != null) tweet]);
  }
  final bool isWithoutGoToParentAction;
  TweetEntity? get tweet => listTweets.isNotEmpty ? listTweets.first : null;
  final FeedUseCases useCase;
  String? tweetContent;
  String? tweetId;
  String? commentId;
  bool isFullyLoaded = false;

  @observable
  ObservableFuture<Either<Failure, FeedCache>>? _progress;

  @observable
  ObservableList<TweetEntity> listTweets = ObservableList<TweetEntity>();

  @observable
  bool isAnonymousMode = false;

  @observable
  bool isEnableCreateButton = false;

  @observable
  TextEditingController editingController = TextEditingController();

  @observable
  String? errorMessage = '';

  bool get allowReply => tweet?.meta.canReply == true;

  @observable
  bool highlightPending = true;

  int get selectedPosition => commentId != null && highlightPending
      ? listTweets.indexWhere((e) => e.id == commentId)
      : invalidPosition;

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> getDetail() async {
    _progress = ObservableFuture(useCase.fetchTweetDetail(tweetId));

    final Either<Failure, FeedCache> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (cache) => _updateListOfTweets(cache),
    );
  }

  @action
  Future<void> fetchNextPage() async {
    if (isFullyLoaded) return;

    _progress = ObservableFuture(useCase.fetchNewestTweetDetail(tweetId));

    final Either<Failure, FeedCache> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (cache) => _updateListOfTweets(cache),
    );
  }

  void highlightDone() {
    highlightPending = false;
  }

  void _updateListOfTweets(FeedCache cache) {
    final tweets = cache.tweets.whereType<TweetEntity>().toList();
    isFullyLoaded = tweets.length == listTweets.length;
    listTweets = tweets.asObservable();
  }

  void reply() {
    Modular.to.pushNamed('/mainboard/reply', arguments: tweet).then((commentId) {
      if (commentId != null) {
        isFullyLoaded = false;
        fetchNextPage();
      }
    });
  }
}
