// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penhas_drawer_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PenhasDrawerController on _PenhasDrawerControllerBase, Store {
  final _$userNameAtom = Atom(name: '_PenhasDrawerControllerBase.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$userAvatarAtom = Atom(name: '_PenhasDrawerControllerBase.userAvatar');

  @override
  String get userAvatar {
    _$userAvatarAtom.reportRead();
    return super.userAvatar;
  }

  @override
  set userAvatar(String value) {
    _$userAvatarAtom.reportWrite(value, super.userAvatar, () {
      super.userAvatar = value;
    });
  }

  final _$showSecurityOptionsAtom =
      Atom(name: '_PenhasDrawerControllerBase.showSecurityOptions');

  @override
  bool get showSecurityOptions {
    _$showSecurityOptionsAtom.reportRead();
    return super.showSecurityOptions;
  }

  @override
  set showSecurityOptions(bool value) {
    _$showSecurityOptionsAtom.reportWrite(value, super.showSecurityOptions, () {
      super.showSecurityOptions = value;
    });
  }

  final _$stealthModeStateAtom =
      Atom(name: '_PenhasDrawerControllerBase.stealthModeState');

  @override
  SecurityToggleState get stealthModeState {
    _$stealthModeStateAtom.reportRead();
    return super.stealthModeState;
  }

  @override
  set stealthModeState(SecurityToggleState value) {
    _$stealthModeStateAtom.reportWrite(value, super.stealthModeState, () {
      super.stealthModeState = value;
    });
  }

  final _$anonymousModeStateAtom =
      Atom(name: '_PenhasDrawerControllerBase.anonymousModeState');

  @override
  SecurityToggleState get anonymousModeState {
    _$anonymousModeStateAtom.reportRead();
    return super.anonymousModeState;
  }

  @override
  set anonymousModeState(SecurityToggleState value) {
    _$anonymousModeStateAtom.reportWrite(value, super.anonymousModeState, () {
      super.anonymousModeState = value;
    });
  }

  final _$_PenhasDrawerControllerBaseActionController =
      ActionController(name: '_PenhasDrawerControllerBase');

  @override
  void logoutPressed() {
    final _$actionInfo = _$_PenhasDrawerControllerBaseActionController
        .startAction(name: '_PenhasDrawerControllerBase.logoutPressed');
    try {
      return super.logoutPressed();
    } finally {
      _$_PenhasDrawerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userAvatar: ${userAvatar},
showSecurityOptions: ${showSecurityOptions},
stealthModeState: ${stealthModeState},
anonymousModeState: ${anonymousModeState}
    ''';
  }
}
