// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_delete_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountDeleteController on _AccountDeleteControllerBase, Store {
  final _$stateAtom = Atom(name: '_AccountDeleteControllerBase.state');

  @override
  ProfileDeleteState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ProfileDeleteState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$retryAsyncAction = AsyncAction('_AccountDeleteControllerBase.retry');

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
