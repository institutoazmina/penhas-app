// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileController on _UserProfileControllerBase, Store {
  final _$currentStateAtom =
      Atom(name: '_UserProfileControllerBase.currentState');

  @override
  UserProfileState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(UserProfileState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$openChannelAsyncAction =
      AsyncAction('_UserProfileControllerBase.openChannel');

  @override
  Future<void> openChannel() {
    return _$openChannelAsyncAction.run(() => super.openChannel());
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
