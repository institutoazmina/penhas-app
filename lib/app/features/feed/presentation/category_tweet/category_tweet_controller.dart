import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_filter_session_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/tweet_filter_preference.dart';

part 'category_tweet_controller.g.dart';

class CategoryTweetController extends _CategoryTweetControllerBase
    with _$CategoryTweetController {
  CategoryTweetController({
    required TweetFilterPreference useCase,
  }) : super(useCase);
}

abstract class _CategoryTweetControllerBase with Store, MapFailureMessage {
  _CategoryTweetControllerBase(this.useCase);

  final TweetFilterPreference useCase;
  String? _currentCategory;

  @observable
  ObservableFuture<Either<Failure, TweetFilterSessionEntity>>? _progress;

  @observable
  ObservableList<TweetFilterEntity> categories =
      ObservableList<TweetFilterEntity>();

  @observable
  String? errorMessage = '';

  @observable
  String? selectedRadio;

  @computed
  PageProgressState get currentState {
    if (_progress == null || _progress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _progress!.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @computed
  bool get reloadFeed {
    return _currentCategory != selectedRadio;
  }

  @action
  Future<void> getCategories() async {
    _progress = ObservableFuture(useCase.retrieve());

    final Either<Failure, TweetFilterSessionEntity> response = await _progress!;
    response.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (filters) => _updateCategory(filters),
    );
  }

  @action
  Future<void> setCategory(String id) async {
    selectedRadio = id;
    useCase.categories = [id];
  }

  @action
  Future<void> apply() async {
    Modular.to.pop(true);
  }

  void _updateCategory(TweetFilterSessionEntity filters) {
    final seleted = filters.categories.firstWhere((e) => e.isSelected);
    selectedRadio = seleted.id;
    _currentCategory = seleted.id;

    categories = filters.categories.asObservable();
  }
}
