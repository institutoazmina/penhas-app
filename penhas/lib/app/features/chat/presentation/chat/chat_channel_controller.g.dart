// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_channel_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatChannelController on _ChatChannelControllerBase, Store {
  final _$currentStateAtom =
      Atom(name: '_ChatChannelControllerBase.currentState');

  @override
  ChatChannelState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(ChatChannelState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$_ChatChannelControllerBaseActionController =
      ActionController(name: '_ChatChannelControllerBase');

  @override
  void blockChat() {
    final _$actionInfo = _$_ChatChannelControllerBaseActionController
        .startAction(name: '_ChatChannelControllerBase.blockChat');
    try {
      return super.blockChat();
    } finally {
      _$_ChatChannelControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteSession() {
    final _$actionInfo = _$_ChatChannelControllerBaseActionController
        .startAction(name: '_ChatChannelControllerBase.deleteSession');
    try {
      return super.deleteSession();
    } finally {
      _$_ChatChannelControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
