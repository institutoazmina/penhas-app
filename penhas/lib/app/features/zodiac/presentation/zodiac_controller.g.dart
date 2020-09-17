// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zodiac_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ZodiacController on _ZodiacControllerBase, Store {
  final _$signAtom = Atom(name: '_ZodiacControllerBase.sign');

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

  final _$signListAtom = Atom(name: '_ZodiacControllerBase.signList');

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

  final _$_ZodiacControllerBaseActionController =
      ActionController(name: '_ZodiacControllerBase');

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
  String toString() {
    return '''
sign: ${sign},
signList: ${signList}
    ''';
  }
}
