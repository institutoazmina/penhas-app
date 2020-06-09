import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'compose_tweet_controller.g.dart';

class ComposeTweetController extends _ComposeTweetControllerBase
    with _$ComposeTweetController {
  ComposeTweetController({@required FeedUseCases useCase}) : super(useCase);
}

abstract class _ComposeTweetControllerBase with Store, MapFailureMessage {
  final FeedUseCases useCase;
  String tweetContent;

  _ComposeTweetControllerBase(this.useCase);

  @observable
  ObservableFuture<Either<Failure, FeedCache>> _progress;

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
  void setTweetContent(String content) {
    isEnableCreateButton = (content != null) && content.isNotEmpty;
    tweetContent = content;
  }

  @action
  Future<void> createTweetPressed() async {
    _setErrorMessage('');
    if (!isEnableCreateButton) {
      return;
    }

    _progress = ObservableFuture(
      useCase.create(tweetContent),
    );

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (valid) => _updatedTweet(),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _updatedTweet() {
    editingController.clear();
  }
}
