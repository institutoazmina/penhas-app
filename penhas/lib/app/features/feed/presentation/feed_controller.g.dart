// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

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
  ObservableList<TweetTiles> get listTweets {
    _$listTweetsAtom.reportRead();
    return super.listTweets;
  }

  @override
  set listTweets(ObservableList<TweetTiles> value) {
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

  final _$fetchOldestPageAsyncAction =
      AsyncAction('_FeedControllerBase.fetchOldestPage');

  @override
  Future<void> fetchOldestPage() {
    return _$fetchOldestPageAsyncAction.run(() => super.fetchOldestPage());
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
