import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'feed_controller.g.dart';

class FeedController extends _FeedControllerBase with _$FeedController {
  FeedController({
    @required FeedUseCases useCase,
  }) : super(useCase);
}

abstract class _FeedControllerBase with Store, MapFailureMessage {
  final FeedUseCases useCase;
  final TweetRequestOption fetchOption = TweetRequestOption();

  _FeedControllerBase(this.useCase);

  @observable
  ObservableFuture<Either<Failure, TweetSessionEntity>> _progress;

  @observable
  ObservableList<TweetEntity> listTweets = ObservableList<TweetEntity>();

  @observable
  String errorMessage;

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
  Future<void> fetchNextPage() async {
    // _progress = ObservableFuture(
    //   repository.fetch(option: fetchOption),
    // );

    // final response = await _progress;
    // response.fold(
    //   (failure) => _setErrorMessage(mapFailureMessage(failure)),
    //   (session) => _updateSessionAction(session),
    // );
  }

  @action
  Future<void> like(TweetEntity tweet) async {
    // if (tweet == null) {
    //   return;
    // }

    // final requestOption = TweetEngageRequestOption(tweetId: tweet.id);
    // final result = await repository.like(option: requestOption);
    // result.fold(
    //   (failure) => _setErrorMessage(mapFailureMessage(failure)),
    //   (tweet) => _updateTweetList(tweet),
    // );
  }

  @action
  Future<void> reply(TweetEntity tweet) async {
    if (tweet == null) {
      return;
    }

    Modular.to.pushNamed('/mainboard/reply', arguments: tweet);
  }

  void _setErrorMessage(String msg) {
    errorMessage = msg;
  }

  void _updateSessionAction(TweetSessionEntity session) {
    listTweets = session.tweets.asObservable();
  }

  void _updateTweetList(TweetEntity tweet) {
    final index = listTweets.indexWhere(
      (e) => e.id == tweet.id,
    );

    if (index > 0) {
      listTweets[index] = tweet;
    }
  }
}
