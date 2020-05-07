// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_three_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordThreeController
    on _ResetPasswordThreeControllerBase, Store {
  Computed<StoreState> _$currentStateComputed;

  @override
  StoreState get currentState => (_$currentStateComputed ??=
          Computed<StoreState>(() => super.currentState))
      .value;

  final _$_progressAtom =
      Atom(name: '_ResetPasswordThreeControllerBase._progress');

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
      Atom(name: '_ResetPasswordThreeControllerBase.errorMessage');

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

  final _$warningPasswordAtom =
      Atom(name: '_ResetPasswordThreeControllerBase.warningPassword');

  @override
  String get warningPassword {
    _$warningPasswordAtom.context.enforceReadPolicy(_$warningPasswordAtom);
    _$warningPasswordAtom.reportObserved();
    return super.warningPassword;
  }

  @override
  set warningPassword(String value) {
    _$warningPasswordAtom.context.conditionallyRunInAction(() {
      super.warningPassword = value;
      _$warningPasswordAtom.reportChanged();
    }, _$warningPasswordAtom, name: '${_$warningPasswordAtom.name}_set');
  }

  final _$nextStepPressedAsyncAction = AsyncAction('nextStepPressed');

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  final _$_ResetPasswordThreeControllerBaseActionController =
      ActionController(name: '_ResetPasswordThreeControllerBase');

  @override
  void setPassword(String password) {
    final _$actionInfo =
        _$_ResetPasswordThreeControllerBaseActionController.startAction();
    try {
      return super.setPassword(password);
    } finally {
      _$_ResetPasswordThreeControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningPassword: ${warningPassword.toString()},currentState: ${currentState.toString()}';
    return '{$string}';
  }
}
