// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_preference_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountPreferenceController on _AccountPreferenceControllerBase, Store {
  Computed<PageProgressState> _$progressComputed;

  @override
  PageProgressState get progress =>
      (_$progressComputed ??= Computed<PageProgressState>(() => super.progress,
              name: '_AccountPreferenceControllerBase.progress'))
          .value;

  final _$_progressAtom =
      Atom(name: '_AccountPreferenceControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, AccountPreferenceSessionEntity>>
      get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(
      ObservableFuture<Either<Failure, AccountPreferenceSessionEntity>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$stateAtom = Atom(name: '_AccountPreferenceControllerBase.state');

  @override
  AccountPreferenceState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AccountPreferenceState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$messageErrorAtom =
      Atom(name: '_AccountPreferenceControllerBase.messageError');

  @override
  String get messageError {
    _$messageErrorAtom.reportRead();
    return super.messageError;
  }

  @override
  set messageError(String value) {
    _$messageErrorAtom.reportWrite(value, super.messageError, () {
      super.messageError = value;
    });
  }

  final _$retryAsyncAction =
      AsyncAction('_AccountPreferenceControllerBase.retry');

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  final _$updateAsyncAction =
      AsyncAction('_AccountPreferenceControllerBase.update');

  @override
  Future<void> update(String key, bool status) {
    return _$updateAsyncAction.run(() => super.update(key, status));
  }

  @override
  String toString() {
    return '''
state: ${state},
messageError: ${messageError},
progress: ${progress}
    ''';
  }
}
