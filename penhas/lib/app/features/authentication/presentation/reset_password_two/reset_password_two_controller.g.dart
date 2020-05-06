// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordTwoController on _ResetPasswordTwoControllerBase, Store {
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

  final _$_ResetPasswordTwoControllerBaseActionController =
      ActionController(name: '_ResetPasswordTwoControllerBase');

  @override
  void setToken(String token) {
    final _$actionInfo =
        _$_ResetPasswordTwoControllerBaseActionController.startAction();
    try {
      return super.setToken(token);
    } finally {
      _$_ResetPasswordTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStepPressed() {
    final _$actionInfo =
        _$_ResetPasswordTwoControllerBaseActionController.startAction();
    try {
      return super.nextStepPressed();
    } finally {
      _$_ResetPasswordTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'errorMessage: ${errorMessage.toString()}';
    return '{$string}';
  }
}
