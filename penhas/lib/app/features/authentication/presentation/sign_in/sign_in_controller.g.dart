// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInControllerBase, Store {
  Computed<bool> _$hasValidEmailAndPasswordComputed;

  @override
  bool get hasValidEmailAndPassword => (_$hasValidEmailAndPasswordComputed ??=
          Computed<bool>(() => super.hasValidEmailAndPassword))
      .value;

  final _$warningEmailAtom = Atom(name: '_SignInControllerBase.warningEmail');

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
      Atom(name: '_SignInControllerBase.warningPassword');

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

  final _$errorMessageAtom = Atom(name: '_SignInControllerBase.errorMessage');

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

  final _$errorAuthenticationMessageAtom =
      Atom(name: '_SignInControllerBase.errorAuthenticationMessage');

  @override
  String get errorAuthenticationMessage {
    _$errorAuthenticationMessageAtom.context
        .enforceReadPolicy(_$errorAuthenticationMessageAtom);
    _$errorAuthenticationMessageAtom.reportObserved();
    return super.errorAuthenticationMessage;
  }

  @override
  set errorAuthenticationMessage(String value) {
    _$errorAuthenticationMessageAtom.context.conditionallyRunInAction(() {
      super.errorAuthenticationMessage = value;
      _$errorAuthenticationMessageAtom.reportChanged();
    }, _$errorAuthenticationMessageAtom,
        name: '${_$errorAuthenticationMessageAtom.name}_set');
  }

  final _$signInWithEmailAndPasswordPressedAsyncAction =
      AsyncAction('signInWithEmailAndPasswordPressed');

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  final _$_SignInControllerBaseActionController =
      ActionController(name: '_SignInControllerBase');

  @override
  void setEmail(String address) {
    final _$actionInfo = _$_SignInControllerBaseActionController.startAction();
    try {
      return super.setEmail(address);
    } finally {
      _$_SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_SignInControllerBaseActionController.startAction();
    try {
      return super.setPassword(password);
    } finally {
      _$_SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'warningEmail: ${warningEmail.toString()},warningPassword: ${warningPassword.toString()},errorMessage: ${errorMessage.toString()},errorAuthenticationMessage: ${errorAuthenticationMessage.toString()},hasValidEmailAndPassword: ${hasValidEmailAndPassword.toString()}';
    return '{$string}';
  }
}
