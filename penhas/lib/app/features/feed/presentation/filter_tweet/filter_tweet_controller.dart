import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

part 'filter_tweet_controller.g.dart';

class FilterTweetController extends _FilterTweetControllerBase
    with _$FilterTweetController {
  FilterTweetController({
    @required TweetFilterPreference useCase,
  }) : super(useCase);
}

abstract class _FilterTweetControllerBase with Store, MapFailureMessage {
  final TweetFilterPreference useCase;

  _FilterTweetControllerBase(this.useCase);

  @observable
  ObservableFuture<Either<Failure, TweetFilterSessionEntity>> _progress;

  @observable
  ObservableList<TweetFilterEntity> tags = ObservableList<TweetFilterEntity>();

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
  Future<void> getTags() async {
    _progress = ObservableFuture(useCase.retreive());

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (tags) => _updateTags(tags),
    );
  }

  @action
  Future<void> setTags(List<String> tags) async {
    useCase.saveTags(tags);
    Modular.to.pop(true);
  }

  @action
  Future<void> reset() async {
    final reset = (useCase.getTags().length > 0);
    useCase.saveTags([]);
    Modular.to.pop(reset);
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _updateTags(TweetFilterSessionEntity filter) {
    this.tags = filter.tags.asObservable();
  }
}
