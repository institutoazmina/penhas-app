import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/states/feed_security_state.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';

part 'feed_controller.g.dart';

class FeedController extends _FeedControllerBase with _$FeedController {
  FeedController({
    @required FeedUseCases useCase,
    @required IAppModulesServices modulesServices,
  }) : super(useCase, modulesServices);
}

abstract class _FeedControllerBase with Store, MapFailureMessage {
  final FeedUseCases useCase;
  StreamSubscription _streamCache;
  final IAppModulesServices _modulesServices;

  _FeedControllerBase(this.useCase, this._modulesServices) {
    _registerDataSource();
    _setupSecurityState();
  }

  @observable
  ObservableFuture<Either<Failure, FeedCache>> _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, FeedCache>> _reloadProgress;

  @observable
  ObservableList<TweetTiles> listTweets = ObservableList<TweetTiles>();

  @observable
  String errorMessage;

  @observable
  FeedSecurityState securityState = FeedSecurityState.disable();

  @computed
  PageProgressState get reloadState {
    if (_reloadProgress == null ||
        _reloadProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _reloadProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @computed
  PageProgressState get fetchState {
    if (_fetchProgress == null ||
        _fetchProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _fetchProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> fetchNextPage() async {
    _setErrorMessage('');
    if (fetchState == PageProgressState.loading) {
      return;
    }

    _fetchProgress = ObservableFuture(useCase.fetchNewestTweet());

    final response = await _fetchProgress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  @action
  Future<void> fetchOldestPage() async {
    _setErrorMessage('');
    if (fetchState == PageProgressState.loading) {
      return;
    }

    _fetchProgress = ObservableFuture(useCase.fetchOldestTweet());

    final response = await _fetchProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  @action
  Future<void> reloadFeed() async {
    _setErrorMessage('');
    if (reloadState == PageProgressState.loading) {
      return;
    }

    _reloadProgress = ObservableFuture(useCase.reloadTweetFeed());

    final response = await _reloadProgress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (_) {}, // é atualizado via stream no _registerDataSource
    );
  }

  @action
  void dispose() {
    _cancelDataSource();
  }

  void _setErrorMessage(String msg) {
    print(msg);
    errorMessage = msg;
  }

  _registerDataSource() {
    _streamCache = useCase.dataSource
        .listen((cache) => listTweets = cache.tweets.asObservable());
  }

  Future<void> _setupSecurityState() async {
    securityState =
        await SecurityModeActionFeature(modulesServices: _modulesServices)
                .isEnabled
            ? FeedSecurityState.enable()
            : FeedSecurityState.disable();
  }

  _cancelDataSource() {
    if (_streamCache != null) {
      _streamCache.cancel();
      _streamCache = null;
    }
  }
}
