// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_three_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpThreeController on _SignUpThreeControllerBase, Store {
  final _$_progressAtom = Atom(name: '_SignUpThreeControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, SessionEntity>> get _progress {
    _$_progressAtom.context.enforceReadPolicy(_$_progressAtom);
    _$_progressAtom.reportObserved();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, SessionEntity>> value) {
    _$_progressAtom.context.conditionallyRunInAction(() {
      super._progress = value;
      _$_progressAtom.reportChanged();
    }, _$_progressAtom, name: '${_$_progressAtom.name}_set');
  }

  final _$errorMessageAtom =
      Atom(name: '_SignUpThreeControllerBase.errorMessage');

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

  final _$warningEmailAtom =
      Atom(name: '_SignUpThreeControllerBase.warningEmail');

  @override
  String get warningEmail {
    _$warningEmailAtom.context.enforceReadPolicy(_$warningEmailAtom);
    _$warningEmailAtom.reportObserved();
    return super.warningEmail;
  }

  @override
  set warningEmail(String value) {
    _$warningEmailAtom.context.conditionallyRunInAction(() {
      super.warningEmail = value;
      _$warningEmailAtom.reportChanged();
    }, _$warningEmailAtom, name: '${_$warningEmailAtom.name}_set');
  }

  final _$warningPasswordAtom =
      Atom(name: '_SignUpThreeControllerBase.warningPassword');

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

  final _$registerUserPressAsyncAction = AsyncAction('registerUserPress');

  @override
  Future<void> registerUserPress() {
    return _$registerUserPressAsyncAction.run(() => super.registerUserPress());
  }

  final _$_SignUpThreeControllerBaseActionController =
      ActionController(name: '_SignUpThreeControllerBase');

  @override
  void setEmail(String email) {
    final _$actionInfo =
        _$_SignUpThreeControllerBaseActionController.startAction();
    try {
      return super.setEmail(email);
    } finally {
      _$_SignUpThreeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo =
        _$_SignUpThreeControllerBaseActionController.startAction();
    try {
      return super.setPassword(password);
    } finally {
      _$_SignUpThreeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningEmail: ${warningEmail.toString()},warningPassword: ${warningPassword.toString()}';
    return '{$string}';
  }
}
