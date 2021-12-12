import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

part 'reply_tweet_controller.g.dart';

class ReplyTweetController extends _ReplyTweetControllerBase
    with _$ReplyTweetController {
  ReplyTweetController({
    required FeedUseCases useCase,
    required TweetEntity? tweet,
  }) : super(useCase, tweet);
}

abstract class _ReplyTweetControllerBase with Store, MapFailureMessage {
  final TweetEntity? tweet;
  final FeedUseCases useCase;
  String? tweetContent;

  _ReplyTweetControllerBase(this.useCase, this.tweet);

  final TweetEntity? tweet;
  final FeedUseCases useCase;
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
  Future<void> replyTweetPressed() async {
    errorMessage = '';
    if (!isEnableCreateButton) {
      return;
    }

    _progress = ObservableFuture(
      useCase.reply(
        mainTweet: tweet!,
        comment: tweetContent,
      ),
    );

    final Either<Failure, FeedCache> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (valid) => _updatedTweet(),
    );
  }

  void _setErrorMessage(String? message) {
    errorMessage = message;
  }

  void _updatedTweet() {
    editingController.clear();
    Modular.to.pop();
  }
}
