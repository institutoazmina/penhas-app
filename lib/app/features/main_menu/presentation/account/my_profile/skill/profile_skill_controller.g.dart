// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_skill_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileSkillController on _ProfileSkillControllerBase, Store {
  late final _$currentStateAtom =
      Atom(name: '_ProfileSkillControllerBase.currentState', context: context);

  @override
  FilterState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(FilterState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  late final _$resetAsyncAction =
      AsyncAction('_ProfileSkillControllerBase.reset', context: context);

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  late final _$setTagsAsyncAction =
      AsyncAction('_ProfileSkillControllerBase.setTags', context: context);

  @override
  Future<void> setTags(List<FilterTagEntity> tags) {
    return _$setTagsAsyncAction.run(() => super.setTags(tags));
  }

  @override
  String toString() {
    return '''
currentState: ${currentState}
    ''';
  }
}
