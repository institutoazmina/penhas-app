// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_routing_profile_chat_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedRoutingProfileChatController
    on _FeedRoutingProfileChatControllerBase, Store {
  late final _$routingStateAtom = Atom(
      name: '_FeedRoutingProfileChatControllerBase.routingState',
      context: context);

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

  late final _$_FeedRoutingProfileChatControllerBaseActionController =
      ActionController(
          name: '_FeedRoutingProfileChatControllerBase', context: context);

  @override
  void retry() {
    final _$actionInfo = _$_FeedRoutingProfileChatControllerBaseActionController
        .startAction(name: '_FeedRoutingProfileChatControllerBase.retry');
    try {
      return super.retry();
    } finally {
      _$_FeedRoutingProfileChatControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
routingState: ${routingState}
    ''';
  }
}
