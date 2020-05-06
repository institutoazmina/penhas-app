// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordController on _ResetPasswordControllerBase, Store {
  final _$errorMessageAtom =
      Atom(name: '_ResetPasswordControllerBase.errorMessage');

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
      Atom(name: '_ResetPasswordControllerBase.warningEmail');

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

  final _$_ResetPasswordControllerBaseActionController =
      ActionController(name: '_ResetPasswordControllerBase');

  @override
  void setEmail(String address) {
    final _$actionInfo =
        _$_ResetPasswordControllerBaseActionController.startAction();
    try {
      return super.setEmail(address);
    } finally {
      _$_ResetPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextStepPressed() {
    final _$actionInfo =
        _$_ResetPasswordControllerBaseActionController.startAction();
    try {
      return super.nextStepPressed();
    } finally {
      _$_ResetPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningEmail: ${warningEmail.toString()}';
    return '{$string}';
  }
}
