// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterController on _FilterControllerBase, Store {
  final _$currentStateAtom = Atom(name: '_FilterControllerBase.currentState');

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

  final _$resetAsyncAction = AsyncAction('_FilterControllerBase.reset');

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  final _$setTagsAsyncAction = AsyncAction('_FilterControllerBase.setTags');

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
