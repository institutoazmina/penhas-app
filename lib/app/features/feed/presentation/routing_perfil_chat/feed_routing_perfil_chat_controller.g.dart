// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_routing_perfil_chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedRoutingPerfilChatController
    on _FeedRoutingPerfilChatControllerBase, Store {
  final _$routingStateAtom =
      Atom(name: '_FeedRoutingPerfilChatControllerBase.routingState');

  @override
  FeedRoutingState get routingState {
    _$routingStateAtom.reportRead();
    return super.routingState;
  }

  @override
  set routingState(FeedRoutingState value) {
    _$routingStateAtom.reportWrite(value, super.routingState, () {
      super.routingState = value;
    });
  }

  final _$retryAsyncAction =
      AsyncAction('_FeedRoutingPerfilChatControllerBase.retry');

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  @override
  String toString() {
    return '''
routingState: ${routingState}
    ''';
  }
}
