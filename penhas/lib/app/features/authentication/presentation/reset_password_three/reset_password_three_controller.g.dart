// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_three_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordThreeController
    on _ResetPasswordThreeControllerBase, Store {
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
  void nextStepPressed() {
    final _$actionInfo =
        _$_ResetPasswordThreeControllerBaseActionController.startAction();
    try {
      return super.nextStepPressed();
    } finally {
      _$_ResetPasswordThreeControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningPassword: ${warningPassword.toString()}';
    return '{$string}';
  }
}
