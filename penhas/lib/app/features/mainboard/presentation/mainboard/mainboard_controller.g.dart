// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainboardController on _MainboardControllerBase, Store {
  final _$selectedIndexAtom =
      Atom(name: '_MainboardControllerBase.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$notificationCounterAtom =
      Atom(name: '_MainboardControllerBase.notificationCounter');

  @override
  int get notificationCounter {
    _$notificationCounterAtom.reportRead();
    return super.notificationCounter;
  }

  @override
  set notificationCounter(int value) {
    _$notificationCounterAtom.reportWrite(value, super.notificationCounter, () {
      super.notificationCounter = value;
    });
  }

  final _$securityStateAtom =
      Atom(name: '_MainboardControllerBase.securityState');

  @override
  MainboardSecurityState get securityState {
    _$securityStateAtom.reportRead();
    return super.securityState;
  }

  @override
  set securityState(MainboardSecurityState value) {
    _$securityStateAtom.reportWrite(value, super.securityState, () {
      super.securityState = value;
    });
  }

  final _$changeAppStateAsyncAction =
      AsyncAction('_MainboardControllerBase.changeAppState');

  @override
  Future changeAppState(material.AppLifecycleState state) {
    return _$changeAppStateAsyncAction.run(() => super.changeAppState(state));
  }

  final _$_MainboardControllerBaseActionController =
      ActionController(name: '_MainboardControllerBase');

  @override
  void resetNotificatinCounter() {
    final _$actionInfo = _$_MainboardControllerBaseActionController.startAction(
        name: '_MainboardControllerBase.resetNotificatinCounter');
    try {
      return super.resetNotificatinCounter();
    } finally {
      _$_MainboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
notificationCounter: ${notificationCounter},
securityState: ${securityState}
    ''';
  }
}
