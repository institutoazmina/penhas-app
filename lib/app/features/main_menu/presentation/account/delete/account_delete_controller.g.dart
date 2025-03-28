// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_delete_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountDeleteController on _AccountDeleteControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_AccountDeleteControllerBase.progressState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_AccountDeleteControllerBase._progress', context: context);

  @override
  ObservableFuture<Either<Failure, ValidField>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_AccountDeleteControllerBase.state', context: context);

  @override
  ProfileDeleteState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfileDeleteState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AccountDeleteControllerBase.errorMessage', context: context);

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

  late final _$deleteAsyncAction =
      AsyncAction('_AccountDeleteControllerBase.delete', context: context);

  @override
  Future<void> delete(String password) {
    return _$deleteAsyncAction.run(() => super.delete(password));
  }

  late final _$retryAsyncAction =
      AsyncAction('_AccountDeleteControllerBase.retry', context: context);

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage},
progressState: ${progressState}
    ''';
  }
}
