// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileEditController on _ProfileEditControllerBase, Store {
  Computed<PageProgressState> _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_ProfileEditControllerBase.progressState'))
      .value;

  final _$_progressAtom = Atom(name: '_ProfileEditControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, AppStateEntity>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, AppStateEntity>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

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
