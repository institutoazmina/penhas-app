import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/states/mainboard_state.dart';
import 'package:penhas/app/core/states/mainboard_store.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'compose_tweet_controller.g.dart';

class ComposeTweetController extends _ComposeTweetControllerBase
    with _$ComposeTweetController {
  ComposeTweetController({
    @required FeedUseCases useCase,
    @required MainboardStore mainboardStore,
  }) : super(useCase, mainboardStore);
}

abstract class _ComposeTweetControllerBase with Store, MapFailureMessage {
  final FeedUseCases useCase;
  final MainboardStore mainboardStore;
  final _tweetContentLimitSize = 2200;
  String tweetContent;

  _ComposeTweetControllerBase(this.useCase, this.mainboardStore);

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

    final content = tweetContent.length > _tweetContentLimitSize
        ? tweetContent.substring(0, _tweetContentLimitSize - 1)
        : tweetContent;

    _progress = ObservableFuture(
      useCase.create(content),
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
    mainboardStore.changePage(to: MainboardState.feed());
  }
}
