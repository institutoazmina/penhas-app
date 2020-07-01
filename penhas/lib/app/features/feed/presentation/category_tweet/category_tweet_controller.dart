import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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
    @required TweetFilterPreference useCase,
  }) : super(useCase);
}

abstract class _CategoryTweetControllerBase with Store, MapFailureMessage {
  final TweetFilterPreference useCase;

  _CategoryTweetControllerBase(this.useCase);

  @observable
  ObservableFuture<Either<Failure, TweetFilterSessionEntity>> _progress;

  @observable
  ObservableList<TweetFilterEntity> categories =
      ObservableList<TweetFilterEntity>();

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

  @observable
  String selectedRadio = '';

  @action
  Future<void> getCategories() async {
    _progress = ObservableFuture(useCase.retreive());

    final response = await _progress;
    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (filters) => _updateCategory(filters),
    );
  }

  @action
  Future<void> setCategory(String id) async {
    return useCase.saveCategory([id]).then((_) => selectedRadio = id);
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _updateCategory(TweetFilterSessionEntity filters) {
    final seleted = filters.categories.firstWhere((e) => e.isSelected);
    if (seleted != null) {
      this.selectedRadio = seleted.id;
    }

    this.categories = filters.categories.asObservable();
  }
}
