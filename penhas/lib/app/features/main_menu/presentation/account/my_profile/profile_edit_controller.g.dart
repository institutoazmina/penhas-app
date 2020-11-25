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

  final _$progressStateAtom =
      Atom(name: '_ProfileEditControllerBase.progressState');

  @override
  PageProgressState get progressState {
    _$progressStateAtom.reportRead();
    return super.progressState;
  }

  @override
  set progressState(PageProgressState value) {
    _$progressStateAtom.reportWrite(value, super.progressState, () {
      super.progressState = value;
    });
  }

  final _$retryAsyncAction = AsyncAction('_ProfileEditControllerBase.retry');

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  final _$editNickNameAsyncAction =
      AsyncAction('_ProfileEditControllerBase.editNickName');

  @override
  Future<void> editNickName(String name) {
    return _$editNickNameAsyncAction.run(() => super.editNickName(name));
  }

  final _$editMinibioAsyncAction =
      AsyncAction('_ProfileEditControllerBase.editMinibio');

  @override
  Future<void> editMinibio(String content) {
    return _$editMinibioAsyncAction.run(() => super.editMinibio(content));
  }

  final _$editSkillAsyncAction =
      AsyncAction('_ProfileEditControllerBase.editSkill');

  @override
  Future<void> editSkill() {
    return _$editSkillAsyncAction.run(() => super.editSkill());
  }

  @override
  String toString() {
    return '''
state: ${state},
progressState: ${progressState}
    ''';
  }
}
