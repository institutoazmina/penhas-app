// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_main_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatMainController on _ChatMainControllerBase, Store {
  late final _$securityStateAtom =
      Atom(name: '_ChatMainControllerBase.securityState', context: context);

  @override
  ChatMainSecurityState get securityState {
    _$securityStateAtom.reportRead();
    return super.securityState;
  }

  @override
  set securityState(ChatMainSecurityState value) {
    _$securityStateAtom.reportWrite(value, super.securityState, () {
      super.securityState = value;
    });
  }

  late final _$tabItemsAtom =
      Atom(name: '_ChatMainControllerBase.tabItems', context: context);

  @override
  ObservableList<ChatTabItem> get tabItems {
    _$tabItemsAtom.reportRead();
    return super.tabItems;
  }

  @override
  set tabItems(ObservableList<ChatTabItem> value) {
    _$tabItemsAtom.reportWrite(value, super.tabItems, () {
      super.tabItems = value;
    });
  }

  @override
  String toString() {
    return '''
securityState: ${securityState},
tabItems: ${tabItems}
    ''';
  }
}
