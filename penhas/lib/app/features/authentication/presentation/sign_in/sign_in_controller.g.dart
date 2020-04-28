// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInControllerBase, Store {
  final _$invalidEmailAddressAtom =
      Atom(name: '_SignInControllerBase.invalidEmailAddress');

  @override
  String get invalidEmailAddress {
    _$invalidEmailAddressAtom.context
        .enforceReadPolicy(_$invalidEmailAddressAtom);
    _$invalidEmailAddressAtom.reportObserved();
    return super.invalidEmailAddress;
  }

  @override
  set invalidEmailAddress(String value) {
    _$invalidEmailAddressAtom.context.conditionallyRunInAction(() {
      super.invalidEmailAddress = value;
      _$invalidEmailAddressAtom.reportChanged();
    }, _$invalidEmailAddressAtom,
        name: '${_$invalidEmailAddressAtom.name}_set');
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
  String toString() {
    final string = 'invalidEmailAddress: ${invalidEmailAddress.toString()}';
    return '{$string}';
  }
}
