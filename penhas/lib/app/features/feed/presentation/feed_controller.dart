import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_request_option.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_session_entity.dart';
import 'package:penhas/app/features/feed/domain/repositories/i_tweet_repositories.dart';

part 'feed_controller.g.dart';

class FeedController extends _FeedControllerBase with _$FeedController {
  final ITweetRepository repository;

  FeedController({@required this.repository}) : super(repository);
}

abstract class _FeedControllerBase with Store, MapFailureMessage {
  final ITweetRepository repository;
  final TweetRequestOption fetchOption = TweetRequestOption();

  _FeedControllerBase(this.repository);

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
    _progress = ObservableFuture(
      repository.retrieve(option: fetchOption),
    );

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) => _updateSessionAction(session),
    );
  }

  void _setErrorMessage(String msg) {
    errorMessage = msg;
  }

  void _updateSessionAction(TweetSessionEntity session) {
    listTweets = session.tweets.asObservable();
  }
}
