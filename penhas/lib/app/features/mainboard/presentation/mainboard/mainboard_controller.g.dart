// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainboardController on _MainboardControllerBase, Store {
  final _$selectedIndexAtom =
      Atom(name: '_MainboardControllerBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.context.enforceReadPolicy(_$selectedIndexAtom);
    _$selectedIndexAtom.reportObserved();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.context.conditionallyRunInAction(() {
      super.selectedIndex = value;
      _$selectedIndexAtom.reportChanged();
    }, _$selectedIndexAtom, name: '${_$selectedIndexAtom.name}_set');
  }

  final _$_MainboardControllerBaseActionController =
      ActionController(name: '_MainboardControllerBase');

  @override
  void logoutPressed() {
    final _$actionInfo =
        _$_MainboardControllerBaseActionController.startAction();
    try {
      return super.logoutPressed();
    } finally {
      _$_MainboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePage(int index) {
    final _$actionInfo =
        _$_MainboardControllerBaseActionController.startAction();
    try {
      return super.changePage(index);
    } finally {
      _$_MainboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'selectedIndex: ${selectedIndex.toString()}';
    return '{$string}';
  }
}
