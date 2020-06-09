// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuizController on _QuizControllerBase, Store {
  final _$userReplyMessageAtom =
      Atom(name: '_QuizControllerBase.userReplyMessage');

  @override
  QuizMessageEntity get userReplyMessage {
    _$userReplyMessageAtom.reportRead();
    return super.userReplyMessage;
  }

  @override
  set userReplyMessage(QuizMessageEntity value) {
    _$userReplyMessageAtom.reportWrite(value, super.userReplyMessage, () {
      super.userReplyMessage = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_QuizControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_QuizControllerBaseActionController =
      ActionController(name: '_QuizControllerBase');

  @override
  void onActionReply(Map<String, String> reply) {
    final _$actionInfo = _$_QuizControllerBaseActionController.startAction(
        name: '_QuizControllerBase.onActionReply');
    try {
      return super.onActionReply(reply);
    } finally {
      _$_QuizControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userReplyMessage: ${userReplyMessage},
errorMessage: ${errorMessage}
    ''';
  }
}
