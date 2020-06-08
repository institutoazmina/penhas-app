import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_engage_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

part 'reply_tweet_controller.g.dart';

class ReplyTweetController extends _ReplyTweetControllerBase
    with _$ReplyTweetController {
  ReplyTweetController({
    @required ITweetRepository repository,
    @required TweetEntity tweet,
  }) : super(repository, tweet);
}

abstract class _ReplyTweetControllerBase with Store, MapFailureMessage {
  final TweetEntity tweet;
  final ITweetRepository repository;
  String tweetContent;

  _ReplyTweetControllerBase(this.repository, this.tweet);

  @observable
  ObservableFuture<Either<Failure, ValidField>> _progress;

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
  Future<void> replyTweetPressed() async {
    _setErrorMessage('');
    if (!isEnableCreateButton) {
      return;
    }

    final requestOption =
        TweetEngageRequestOption(tweetId: tweet.id, message: tweetContent);
    _progress = ObservableFuture(
      repository.reply(
        option: requestOption,
      ),
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
    Modular.to.pop();
  }
}
