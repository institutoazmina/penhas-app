import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'feed_controller.g.dart';

class FeedController extends _FeedControllerBase with _$FeedController {
  FeedController({
    @required FeedUseCases useCase,
  }) : super(useCase);
}

abstract class _FeedControllerBase with Store, MapFailureMessage {
  final FeedUseCases useCase;

  _FeedControllerBase(this.useCase) {
    _registerDataSource();
  }

  @observable
  ObservableFuture<Either<Failure, FeedCache>> _progress;

  @observable
  ObservableList<TweetTiles> listTweets = ObservableList<TweetTiles>();

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
    if (currentState == PageProgressState.loading) {
      return;
    }

    _progress = ObservableFuture(useCase.fetchNewestTweet());

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  @action
  Future<void> fetchOldestPage() async {
    if (currentState == PageProgressState.loading) {
      return;
    }

    final response = await useCase.fetchOldestTweet();

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  @action
  Future<void> reloadFeed() async {
    if (currentState == PageProgressState.loading) {
      return;
    }

    _progress = ObservableFuture(useCase.reloadTweetFeed());

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  void _setErrorMessage(String msg) {
    errorMessage = msg;
  }

  _registerDataSource() {
    useCase.dataSource.listen((cache) {
      listTweets = cache.tweets.asObservable();
    });
  }
}
