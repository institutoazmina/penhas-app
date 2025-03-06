// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserProfileController on _UserProfileControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_UserProfileControllerBase.state', context: context);

  @override
  UserProfileState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(UserProfileState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$menuStateAtom =
      Atom(name: '_UserProfileControllerBase.menuState', context: context);

  @override
  UserMenuState get menuState {
    _$menuStateAtom.reportRead();
    return super.menuState;
  }

  @override
  set menuState(UserMenuState value) {
    _$menuStateAtom.reportWrite(value, super.menuState, () {
      super.menuState = value;
    });
  }

  late final _$reactionAtom =
      Atom(name: '_UserProfileControllerBase.reaction', context: context);

  @override
  UserProfileReaction? get reaction {
    _$reactionAtom.reportRead();
    return super.reaction;
  }

  @override
  set reaction(UserProfileReaction? value) {
    _$reactionAtom.reportWrite(value, super.reaction, () {
      super.reaction = value;
    });
  }

  late final _$openChannelAsyncAction =
      AsyncAction('_UserProfileControllerBase.openChannel', context: context);

  @override
  Future<void> openChannel() {
    return _$openChannelAsyncAction.run(() => super.openChannel());
  }

  late final _$onSendReportPressedAsyncAction = AsyncAction(
      '_UserProfileControllerBase.onSendReportPressed',
      context: context);

  @override
  Future<void> onSendReportPressed(String reason) {
    return _$onSendReportPressedAsyncAction
        .run(() => super.onSendReportPressed(reason));
  }

  late final _$onConfirmBlockPressedAsyncAction = AsyncAction(
      '_UserProfileControllerBase.onConfirmBlockPressed',
      context: context);

  @override
  Future<void> onConfirmBlockPressed() {
    return _$onConfirmBlockPressedAsyncAction
        .run(() => super.onConfirmBlockPressed());
  }

  late final _$_UserProfileControllerBaseActionController =
      ActionController(name: '_UserProfileControllerBase', context: context);

  @override
  void onTapMenuOptions() {
    final _$actionInfo = _$_UserProfileControllerBaseActionController
        .startAction(name: '_UserProfileControllerBase.onTapMenuOptions');
    try {
      return super.onTapMenuOptions();
    } finally {
      _$_UserProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onOptionSelected(UserProfileSelectedOption? option) {
    final _$actionInfo = _$_UserProfileControllerBaseActionController
        .startAction(name: '_UserProfileControllerBase.onOptionSelected');
    try {
      return super.onOptionSelected(option);
    } finally {
      _$_UserProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
menuState: ${menuState},
reaction: ${reaction}
    ''';
  }
}
