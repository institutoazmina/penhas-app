// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_main_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatMainController on _ChatMainControllerBase, Store {
  final _$showPeopleScreenAtom =
      Atom(name: '_ChatMainControllerBase.showPeopleScreen');

  @override
  bool get showPeopleScreen {
    _$showPeopleScreenAtom.reportRead();
    return super.showPeopleScreen;
  }

  @override
  set showPeopleScreen(bool value) {
    _$showPeopleScreenAtom.reportWrite(value, super.showPeopleScreen, () {
      super.showPeopleScreen = value;
    });
  }

  @override
  String toString() {
    return '''
showPeopleScreen: ${showPeopleScreen}
    ''';
  }
}
