// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileEditController on _ProfileEditControllerBase, Store {
  final _$stateAtom = Atom(name: '_ProfileEditControllerBase.state');

  @override
  ProfileEditState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfileEditState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_ProfileEditControllerBaseActionController =
      ActionController(name: '_ProfileEditControllerBase');

  @override
  Future<void> retry() {
    final _$actionInfo = _$_ProfileEditControllerBaseActionController
        .startAction(name: '_ProfileEditControllerBase.retry');
    try {
      return super.retry();
    } finally {
      _$_ProfileEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
