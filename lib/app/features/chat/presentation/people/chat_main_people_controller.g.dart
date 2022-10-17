// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_main_people_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatMainPeopleController on _ChatMainPeopleControllerBase, Store {
  final _$currentStateAtom =
      Atom(name: '_ChatMainPeopleControllerBase.currentState');

  @override
  ChatMainTalksState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(ChatMainTalksState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$reloadAsyncAction =
      AsyncAction('_ChatMainPeopleControllerBase.reload');

  @override
  Future<void> reload() {
    return _$reloadAsyncAction.run(() => super.reload());
  }

  final _$filterAsyncAction =
      AsyncAction('_ChatMainPeopleControllerBase.filter');

  @override
  Future<void> filter() {
    return _$filterAsyncAction.run(() => super.filter());
  }

  final _$_ChatMainPeopleControllerBaseActionController =
      ActionController(name: '_ChatMainPeopleControllerBase');

  @override
  Future<void> profile(UserDetailProfileEntity profile) {
    final _$actionInfo = _$_ChatMainPeopleControllerBaseActionController
        .startAction(name: '_ChatMainPeopleControllerBase.profile');
    try {
      return super.profile(profile);
    } finally {
      _$_ChatMainPeopleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
