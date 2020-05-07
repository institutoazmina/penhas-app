// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordTwoController on _ResetPasswordTwoControllerBase, Store {
  Computed<StoreState> _$currentStateComputed;

  @override
  StoreState get currentState => (_$currentStateComputed ??=
          Computed<StoreState>(() => super.currentState))
      .value;

  final _$_progressAtom =
      Atom(name: '_ResetPasswordTwoControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, ValidField>> get _progress {
    _$_progressAtom.context.enforceReadPolicy(_$_progressAtom);
    _$_progressAtom.reportObserved();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>> value) {
    _$_progressAtom.context.conditionallyRunInAction(() {
      super._progress = value;
      _$_progressAtom.reportChanged();
    }, _$_progressAtom, name: '${_$_progressAtom.name}_set');
  }

  final _$errorMessageAtom =
      Atom(name: '_ResetPasswordTwoControllerBase.errorMessage');

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

  final _$warrningTokenAtom =
      Atom(name: '_ResetPasswordTwoControllerBase.warrningToken');

  @override
  String get warrningToken {
    _$warrningTokenAtom.context.enforceReadPolicy(_$warrningTokenAtom);
    _$warrningTokenAtom.reportObserved();
    return super.warrningToken;
  }

  @override
  set warrningToken(String value) {
    _$warrningTokenAtom.context.conditionallyRunInAction(() {
      super.warrningToken = value;
      _$warrningTokenAtom.reportChanged();
    }, _$warrningTokenAtom, name: '${_$warrningTokenAtom.name}_set');
  }

  final _$setTokenAsyncAction = AsyncAction('setToken');

  @override
  Future<void> setToken(String token) {
    return _$setTokenAsyncAction.run(() => super.setToken(token));
  }

  final _$nextStepPressedAsyncAction = AsyncAction('nextStepPressed');

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warrningToken: ${warrningToken.toString()},currentState: ${currentState.toString()}';
    return '{$string}';
  }
}
