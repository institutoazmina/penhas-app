// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileController on _UserProfileControllerBase, Store {
  final _$stateAtom = Atom(name: '_UserProfileControllerBase.state');

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

  final _$menuStateAtom = Atom(name: '_UserProfileControllerBase.menuState');

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

  final _$reactionAtom = Atom(name: '_UserProfileControllerBase.reaction');

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

  final _$openChannelAsyncAction =
      AsyncAction('_UserProfileControllerBase.openChannel');

  @override
  Future<void> openChannel() {
    return _$openChannelAsyncAction.run(() => super.openChannel());
  }

  final _$_UserProfileControllerBaseActionController =
      ActionController(name: '_UserProfileControllerBase');

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
