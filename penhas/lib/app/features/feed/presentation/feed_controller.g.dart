// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  Computed<PageProgressState> _$reloadStateComputed;

  @override
  PageProgressState get reloadState => (_$reloadStateComputed ??=
          Computed<PageProgressState>(() => super.reloadState,
              name: '_FeedControllerBase.reloadState'))
      .value;
  Computed<PageProgressState> _$fetchStateComputed;

  @override
  PageProgressState get fetchState => (_$fetchStateComputed ??=
          Computed<PageProgressState>(() => super.fetchState,
              name: '_FeedControllerBase.fetchState'))
      .value;

  final _$_fetchProgressAtom = Atom(name: '_FeedControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, FeedCache>> get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(ObservableFuture<Either<Failure, FeedCache>> value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$_reloadProgressAtom =
      Atom(name: '_FeedControllerBase._reloadProgress');

  @override
  ObservableFuture<Either<Failure, FeedCache>> get _reloadProgress {
    _$_reloadProgressAtom.reportRead();
    return super._reloadProgress;
  }

  @override
  set _reloadProgress(ObservableFuture<Either<Failure, FeedCache>> value) {
    _$_reloadProgressAtom.reportWrite(value, super._reloadProgress, () {
      super._reloadProgress = value;
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

  final _$reloadFeedAsyncAction = AsyncAction('_FeedControllerBase.reloadFeed');

  @override
  Future<void> reloadFeed() {
    return _$reloadFeedAsyncAction.run(() => super.reloadFeed());
  }

  final _$_FeedControllerBaseActionController =
      ActionController(name: '_FeedControllerBase');

  @override
  void dispose() {
    final _$actionInfo = _$_FeedControllerBaseActionController.startAction(
        name: '_FeedControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_FeedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listTweets: ${listTweets},
errorMessage: ${errorMessage},
reloadState: ${reloadState},
fetchState: ${fetchState}
    ''';
  }
}
