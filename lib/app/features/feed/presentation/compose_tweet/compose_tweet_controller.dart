import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../mainboard/domain/states/mainboard_state.dart';
import '../../../mainboard/domain/states/mainboard_store.dart';
import '../../domain/usecases/feed_use_cases.dart';

part 'compose_tweet_controller.g.dart';

class ComposeTweetController extends _ComposeTweetControllerBase
    with _$ComposeTweetController {
  ComposeTweetController({
    required FeedUseCases useCase,
    required MainboardStore mainboardStore,
  }) : super(useCase, mainboardStore);
}

abstract class _ComposeTweetControllerBase with Store, MapFailureMessage {
  _ComposeTweetControllerBase(this.useCase, this.mainboardStore);

  final FeedUseCases useCase;
  final MainboardStore mainboardStore;
  final _tweetContentLimitSize = 2200;
  String? tweetContent;

  @observable
  ObservableFuture<Either<Failure, FeedCache>>? _progress;

  @observable
  bool isAnonymousMode = false;

  @observable
  bool isEnableCreateButton = false;

  @observable
  TextEditingController editingController = TextEditingController();

  @observable
  String? errorMessage = '';

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
    tweetContent = content;
  }

  @action
  Future<void> createTweetPressed() async {
    errorMessage = '';
    if (!isEnableCreateButton) {
      return;
    }

    final content = tweetContent!.length > _tweetContentLimitSize
        ? tweetContent!.substring(0, _tweetContentLimitSize - 1)
        : tweetContent;

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
    mainboardStore.changePage(to: const MainboardState.feed());
  }
}
