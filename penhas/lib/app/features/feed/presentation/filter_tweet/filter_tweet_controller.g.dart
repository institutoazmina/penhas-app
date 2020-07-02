// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_tweet_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterTweetController on _FilterTweetControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_FilterTweetControllerBase.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_FilterTweetControllerBase._progress');

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

  final _$tagsAtom = Atom(name: '_FilterTweetControllerBase.tags');

  @override
  ObservableList<TweetFilterEntity> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<TweetFilterEntity> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_FilterTweetControllerBase.errorMessage');

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

  final _$getTagsAsyncAction =
      AsyncAction('_FilterTweetControllerBase.getTags');

  @override
  Future<void> getTags() {
    return _$getTagsAsyncAction.run(() => super.getTags());
  }

  final _$setTagsAsyncAction =
      AsyncAction('_FilterTweetControllerBase.setTags');

  @override
  Future<void> setTags(List<String> tags) {
    return _$setTagsAsyncAction.run(() => super.setTags(tags));
  }

  @override
  String toString() {
    return '''
tags: ${tags},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
