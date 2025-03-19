// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainboard_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainboardController on MainboardControllerBase, Store {
  late final _$selectedIndexAtom =
      Atom(name: 'MainboardControllerBase.selectedIndex', context: context);

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

  late final _$notificationCounterAtom = Atom(
      name: 'MainboardControllerBase.notificationCounter', context: context);

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

  late final _$changeAppStateAsyncAction =
      AsyncAction('MainboardControllerBase.changeAppState', context: context);

  @override
  Future<void> changeAppState(material.AppLifecycleState state) {
    return _$changeAppStateAsyncAction.run(() => super.changeAppState(state));
  }

  late final _$MainboardControllerBaseActionController =
      ActionController(name: 'MainboardControllerBase', context: context);

  @override
  void resetNotificationCounter() {
    final _$actionInfo = _$MainboardControllerBaseActionController.startAction(
        name: 'MainboardControllerBase.resetNotificationCounter');
    try {
      return super.resetNotificationCounter();
    } finally {
      _$MainboardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
notificationCounter: ${notificationCounter}
    ''';
  }
}
