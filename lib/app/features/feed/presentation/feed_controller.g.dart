// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedController on FeedControllerBase, Store {
  Computed<PageProgressState>? _$fetchStateComputed;

  @override
  PageProgressState get fetchState => (_$fetchStateComputed ??=
          Computed<PageProgressState>(() => super.fetchState,
              name: 'FeedControllerBase.fetchState'))
      .value;
  Computed<PageProgressState>? _$reloadStateComputed;

  @override
  PageProgressState get reloadState => (_$reloadStateComputed ??=
          Computed<PageProgressState>(() => super.reloadState,
              name: 'FeedControllerBase.reloadState'))
      .value;

  late final _$stateAtom =
      Atom(name: 'FeedControllerBase.state', context: context);

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

  late final _$isComposeTweetFabVisibleAtom = Atom(
      name: 'FeedControllerBase.isComposeTweetFabVisible', context: context);

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

  late final _$securityStateAtom =
      Atom(name: 'FeedControllerBase.securityState', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'FeedControllerBase.errorMessage', context: context);

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

  late final _$_fetchProgressAtom =
      Atom(name: 'FeedControllerBase._fetchProgress', context: context);

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

  late final _$_reloadProgressAtom =
      Atom(name: 'FeedControllerBase._reloadProgress', context: context);

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

  late final _$reloadFeedAsyncAction =
      AsyncAction('FeedControllerBase.reloadFeed', context: context);

  @override
  Future<void> reloadFeed() {
    return _$reloadFeedAsyncAction.run(() => super.reloadFeed());
  }

  late final _$disposeAsyncAction =
      AsyncAction('FeedControllerBase.dispose', context: context);

  @override
  Future<void> dispose() {
    return _$disposeAsyncAction.run(() => super.dispose());
  }

  late final _$FeedControllerBaseActionController =
      ActionController(name: 'FeedControllerBase', context: context);

  @override
  Future<void> fetchNextPage() {
    final _$actionInfo = _$FeedControllerBaseActionController.startAction(
        name: 'FeedControllerBase.fetchNextPage');
    try {
      return super.fetchNextPage();
    } finally {
      _$FeedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> fetchOldestPage() {
    final _$actionInfo = _$FeedControllerBaseActionController.startAction(
        name: 'FeedControllerBase.fetchOldestPage');
    try {
      return super.fetchOldestPage();
    } finally {
      _$FeedControllerBaseActionController.endAction(_$actionInfo);
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
