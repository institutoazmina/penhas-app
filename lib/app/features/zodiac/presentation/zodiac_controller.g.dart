// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zodiac_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ZodiacController on _ZodiacControllerBase, Store {
  late final _$signAtom =
      Atom(name: '_ZodiacControllerBase.sign', context: context);

  @override
  IZodiac get sign {
    _$signAtom.reportRead();
    return super.sign;
  }

  @override
  set sign(IZodiac value) {
    _$signAtom.reportWrite(value, super.sign, () {
      super.sign = value;
    });
  }

  late final _$signListAtom =
      Atom(name: '_ZodiacControllerBase.signList', context: context);

  @override
  ObservableList<IZodiac> get signList {
    _$signListAtom.reportRead();
    return super.signList;
  }

  @override
  set signList(ObservableList<IZodiac> value) {
    _$signListAtom.reportWrite(value, super.signList, () {
      super.signList = value;
    });
  }

  late final _$isSecurityRunningAtom =
      Atom(name: '_ZodiacControllerBase.isSecurityRunning', context: context);

  @override
  bool get isSecurityRunning {
    _$isSecurityRunningAtom.reportRead();
    return super.isSecurityRunning;
  }

  @override
  set isSecurityRunning(bool value) {
    _$isSecurityRunningAtom.reportWrite(value, super.isSecurityRunning, () {
      super.isSecurityRunning = value;
    });
  }

  late final _$_ZodiacControllerBaseActionController =
      ActionController(name: '_ZodiacControllerBase', context: context);

  @override
  void forwardStealthLogin() {
    final _$actionInfo = _$_ZodiacControllerBaseActionController.startAction(
        name: '_ZodiacControllerBase.forwardStealthLogin');
    try {
      return super.forwardStealthLogin();
    } finally {
      _$_ZodiacControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stealthAction() {
    final _$actionInfo = _$_ZodiacControllerBaseActionController.startAction(
        name: '_ZodiacControllerBase.stealthAction');
    try {
      return super.stealthAction();
    } finally {
      _$_ZodiacControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_ZodiacControllerBaseActionController.startAction(
        name: '_ZodiacControllerBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_ZodiacControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sign: ${sign},
signList: ${signList},
isSecurityRunning: ${isSecurityRunning}
    ''';
  }
}
