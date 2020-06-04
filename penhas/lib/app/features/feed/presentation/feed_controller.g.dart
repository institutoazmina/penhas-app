// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState))
      .value;

  final _$_progressAtom = Atom(name: '_FeedControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, TweetSessionEntity>> get _progress {
    _$_progressAtom.context.enforceReadPolicy(_$_progressAtom);
    _$_progressAtom.reportObserved();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, TweetSessionEntity>> value) {
    _$_progressAtom.context.conditionallyRunInAction(() {
      super._progress = value;
      _$_progressAtom.reportChanged();
    }, _$_progressAtom, name: '${_$_progressAtom.name}_set');
  }

  final _$listTweetsAtom = Atom(name: '_FeedControllerBase.listTweets');

  @override
  ObservableList<TweetEntity> get listTweets {
    _$listTweetsAtom.context.enforceReadPolicy(_$listTweetsAtom);
    _$listTweetsAtom.reportObserved();
    return super.listTweets;
  }

  @override
  set listTweets(ObservableList<TweetEntity> value) {
    _$listTweetsAtom.context.conditionallyRunInAction(() {
      super.listTweets = value;
      _$listTweetsAtom.reportChanged();
    }, _$listTweetsAtom, name: '${_$listTweetsAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_FeedControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$fetchNextPageAsyncAction = AsyncAction('fetchNextPage');

  @override
  Future<void> fetchNextPage() {
    return _$fetchNextPageAsyncAction.run(() => super.fetchNextPage());
  }

  final _$likeAsyncAction = AsyncAction('like');

  @override
  Future<void> like(TweetEntity tweet) {
    return _$likeAsyncAction.run(() => super.like(tweet));
  }

  final _$replyAsyncAction = AsyncAction('reply');

  @override
  Future<void> reply(TweetEntity tweet) {
    return _$replyAsyncAction.run(() => super.reply(tweet));
  }

  @override
  String toString() {
    final string =
        'listTweets: ${listTweets.toString()},errorMessage: ${errorMessage.toString()},currentState: ${currentState.toString()}';
    return '{$string}';
  }
}
