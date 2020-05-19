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
    _$userReplyMessageAtom.context.enforceReadPolicy(_$userReplyMessageAtom);
    _$userReplyMessageAtom.reportObserved();
    return super.userReplyMessage;
  }

  @override
  set userReplyMessage(QuizMessageEntity value) {
    _$userReplyMessageAtom.context.conditionallyRunInAction(() {
      super.userReplyMessage = value;
      _$userReplyMessageAtom.reportChanged();
    }, _$userReplyMessageAtom, name: '${_$userReplyMessageAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_QuizControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$_QuizControllerBaseActionController =
      ActionController(name: '_QuizControllerBase');

  @override
  void onActionReply(Map<String, String> reply) {
    final _$actionInfo = _$_QuizControllerBaseActionController.startAction();
    try {
      return super.onActionReply(reply);
    } finally {
      _$_QuizControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'userReplyMessage: ${userReplyMessage.toString()},errorMessage: ${errorMessage.toString()}';
    return '{$string}';
  }
}
