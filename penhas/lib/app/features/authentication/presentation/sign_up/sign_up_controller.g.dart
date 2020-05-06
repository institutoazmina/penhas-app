// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpControllerBase, Store {
  final _$errorMessageAtom = Atom(name: '_SignUpControllerBase.errorMessage');

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

  final _$warningFullnameAtom =
      Atom(name: '_SignUpControllerBase.warningFullname');

  @override
  String get warningFullname {
    _$warningFullnameAtom.context.enforceReadPolicy(_$warningFullnameAtom);
    _$warningFullnameAtom.reportObserved();
    return super.warningFullname;
  }

  @override
  set warningFullname(String value) {
    _$warningFullnameAtom.context.conditionallyRunInAction(() {
      super.warningFullname = value;
      _$warningFullnameAtom.reportChanged();
    }, _$warningFullnameAtom, name: '${_$warningFullnameAtom.name}_set');
  }

  final _$warningCpfAtom = Atom(name: '_SignUpControllerBase.warningCpf');

  @override
  String get warningCpf {
    _$warningCpfAtom.context.enforceReadPolicy(_$warningCpfAtom);
    _$warningCpfAtom.reportObserved();
    return super.warningCpf;
  }

  @override
  set warningCpf(String value) {
    _$warningCpfAtom.context.conditionallyRunInAction(() {
      super.warningCpf = value;
      _$warningCpfAtom.reportChanged();
    }, _$warningCpfAtom, name: '${_$warningCpfAtom.name}_set');
  }

  final _$_SignUpControllerBaseActionController =
      ActionController(name: '_SignUpControllerBase');

  @override
  void setFullname(String fullname) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setFullname(fullname);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(DateTime birthday) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setBirthday(birthday);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCpf(String cpf) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setCpf(cpf);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningFullname: ${warningFullname.toString()},warningCpf: ${warningCpf.toString()}';
    return '{$string}';
  }
}
