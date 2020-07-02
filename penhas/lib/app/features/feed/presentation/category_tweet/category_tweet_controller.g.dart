// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryTweetController on _CategoryTweetControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_CategoryTweetControllerBase.currentState'))
      .value;
  Computed<bool> _$reloadFeedComputed;

  @override
  bool get reloadFeed =>
      (_$reloadFeedComputed ??= Computed<bool>(() => super.reloadFeed,
              name: '_CategoryTweetControllerBase.reloadFeed'))
          .value;

  final _$_progressAtom = Atom(name: '_CategoryTweetControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, TweetFilterSessionEntity>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(
      ObservableFuture<Either<Failure, TweetFilterSessionEntity>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$categoriesAtom =
      Atom(name: '_CategoryTweetControllerBase.categories');

  @override
  ObservableList<TweetFilterEntity> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<TweetFilterEntity> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_CategoryTweetControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$selectedRadioAtom =
      Atom(name: '_CategoryTweetControllerBase.selectedRadio');

  @override
  String get selectedRadio {
    _$selectedRadioAtom.reportRead();
    return super.selectedRadio;
  }

  @override
  set selectedRadio(String value) {
    _$selectedRadioAtom.reportWrite(value, super.selectedRadio, () {
      super.selectedRadio = value;
    });
  }

  final _$getCategoriesAsyncAction =
      AsyncAction('_CategoryTweetControllerBase.getCategories');

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  final _$setCategoryAsyncAction =
      AsyncAction('_CategoryTweetControllerBase.setCategory');

  @override
  Future<void> setCategory(String id) {
    return _$setCategoryAsyncAction.run(() => super.setCategory(id));
  }

  @override
  String toString() {
    return '''
categories: ${categories},
errorMessage: ${errorMessage},
selectedRadio: ${selectedRadio},
currentState: ${currentState},
reloadFeed: ${reloadFeed}
    ''';
  }
}
