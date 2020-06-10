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
          Computed<PageProgressState>(() => super.currentState,
              name: '_FeedControllerBase.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_FeedControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, FeedCache>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, FeedCache>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$listTweetsAtom = Atom(name: '_FeedControllerBase.listTweets');

  @override
  ObservableList<TweetEntity> get listTweets {
    _$listTweetsAtom.reportRead();
    return super.listTweets;
  }

  @override
  set listTweets(ObservableList<TweetEntity> value) {
    _$listTweetsAtom.reportWrite(value, super.listTweets, () {
      super.listTweets = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_FeedControllerBase.errorMessage');

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

  final _$fetchNextPageAsyncAction =
      AsyncAction('_FeedControllerBase.fetchNextPage');

  @override
  Future<void> fetchNextPage() {
    return _$fetchNextPageAsyncAction.run(() => super.fetchNextPage());
  }

  final _$likeAsyncAction = AsyncAction('_FeedControllerBase.like');

  @override
  Future<void> like(TweetEntity tweet) {
    return _$likeAsyncAction.run(() => super.like(tweet));
  }

  final _$replyAsyncAction = AsyncAction('_FeedControllerBase.reply');

  @override
  Future<void> reply(TweetEntity tweet) {
    return _$replyAsyncAction.run(() => super.reply(tweet));
  }

  final _$actionDeleteAsyncAction =
      AsyncAction('_FeedControllerBase.actionDelete');

  @override
  Future<void> actionDelete(TweetEntity tweet) {
    return _$actionDeleteAsyncAction.run(() => super.actionDelete(tweet));
  }

  final _$actionReportAsyncAction =
      AsyncAction('_FeedControllerBase.actionReport');

  @override
  Future<void> actionReport(TweetEntity tweet) {
    return _$actionReportAsyncAction.run(() => super.actionReport(tweet));
  }

  @override
  String toString() {
    return '''
listTweets: ${listTweets},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
