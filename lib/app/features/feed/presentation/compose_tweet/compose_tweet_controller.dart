import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../domain/usecases/feed_use_cases.dart';
import 'compose_tweet_navigator.dart';

part 'compose_tweet_controller.g.dart';

const _tweetContentLimitSize = 2200;

class ComposeTweetController = _ComposeTweetControllerBase
    with _$ComposeTweetController;

abstract class _ComposeTweetControllerBase with Store, MapFailureMessage {
  _ComposeTweetControllerBase({
    required this.useCase,
    required this.navigator,
    TextEditingController? textEditingController,
  }) : editingController = textEditingController ?? TextEditingController();

  final FeedUseCases useCase;
  final ComposeTweetNavigator navigator;
  final TextEditingController editingController;

  String _tweetContent = '';

  @observable
  ObservableFuture<Either<Failure, FeedCache>>? _progress;

  @observable
  bool isAnonymousMode = false;

  @observable
  bool isEnableCreateButton = false;

  @observable
  String errorMessage = '';

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
  void setTweetContent(String content) {
    isEnableCreateButton = content.isNotEmpty;
    _tweetContent = content;
  }

  @action
  Future<void> createTweetPressed() async {
    errorMessage = '';
    if (!isEnableCreateButton) {
      return;
    }

    final content = _tweetContent.length > _tweetContentLimitSize
        ? _tweetContent.substring(0, _tweetContentLimitSize)
        : _tweetContent;

    _progress = ObservableFuture(
      useCase.create(content),
    );

    final Either<Failure, FeedCache> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (valid) => _updatedTweet(),
    );
  }

  void _updatedTweet() {
    editingController.clear();
    navigator.navigateToFeed();
  }
}
