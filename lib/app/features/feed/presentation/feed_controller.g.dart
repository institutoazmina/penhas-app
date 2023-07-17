// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedController on _FeedControllerBase, Store {
  Computed<PageProgressState>? _$fetchStateComputed;

  @override
  PageProgressState get fetchState => (_$fetchStateComputed ??=
          Computed<PageProgressState>(() => super.fetchState,
              name: '_FeedControllerBase.fetchState'))
      .value;
  Computed<PageProgressState>? _$reloadStateComputed;

  @override
  PageProgressState get reloadState => (_$reloadStateComputed ??=
          Computed<PageProgressState>(() => super.reloadState,
              name: '_FeedControllerBase.reloadState'))
      .value;

  final _$stateAtom = Atom(name: '_FeedControllerBase.state');

  @override
  FeedState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(FeedState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$isComposeTweetFabVisibleAtom =
      Atom(name: '_FeedControllerBase.isComposeTweetFabVisible');

  @override
  bool get isComposeTweetFabVisible {
    _$isComposeTweetFabVisibleAtom.reportRead();
    return super.isComposeTweetFabVisible;
  }

  @override
  set isComposeTweetFabVisible(bool value) {
    _$isComposeTweetFabVisibleAtom
        .reportWrite(value, super.isComposeTweetFabVisible, () {
      super.isComposeTweetFabVisible = value;
    });
  }

  final _$securityStateAtom = Atom(name: '_FeedControllerBase.securityState');

  @override
  FeedSecurityState get securityState {
    _$securityStateAtom.reportRead();
    return super.securityState;
  }

  @override
  set securityState(FeedSecurityState value) {
    _$securityStateAtom.reportWrite(value, super.securityState, () {
      super.securityState = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_FeedControllerBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_fetchProgressAtom = Atom(name: '_FeedControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, FeedCache>>? get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(ObservableFuture<Either<Failure, FeedCache>>? value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$_reloadProgressAtom =
      Atom(name: '_FeedControllerBase._reloadProgress');

  @override
  ObservableFuture<Either<Failure, FeedCache>>? get _reloadProgress {
    _$_reloadProgressAtom.reportRead();
    return super._reloadProgress;
  }

  @override
  set _reloadProgress(ObservableFuture<Either<Failure, FeedCache>>? value) {
    _$_reloadProgressAtom.reportWrite(value, super._reloadProgress, () {
      super._reloadProgress = value;
    });
  }

  final _$reloadFeedAsyncAction = AsyncAction('_FeedControllerBase.reloadFeed');

  @override
  Future<void> reloadFeed() {
    return _$reloadFeedAsyncAction.run(() => super.reloadFeed());
  }

  final _$disposeAsyncAction = AsyncAction('_FeedControllerBase.dispose');

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  final _$_FeedControllerBaseActionController =
      ActionController(name: '_FeedControllerBase');

  @override
  Future<void> fetchNextPage() {
    final _$actionInfo = _$_FeedControllerBaseActionController.startAction(
        name: '_FeedControllerBase.fetchNextPage');
    try {
      return super.fetchNextPage();
    } finally {
      _$_FeedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> fetchOldestPage() {
    final _$actionInfo = _$_FeedControllerBaseActionController.startAction(
        name: '_FeedControllerBase.fetchOldestPage');
    try {
      return super.fetchOldestPage();
    } finally {
      _$_FeedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
isComposeTweetFabVisible: ${isComposeTweetFabVisible},
securityState: ${securityState},
errorMessage: ${errorMessage},
fetchState: ${fetchState},
reloadState: ${reloadState}
    ''';
  }
}
