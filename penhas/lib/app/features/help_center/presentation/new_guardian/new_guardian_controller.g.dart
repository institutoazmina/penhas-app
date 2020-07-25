// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_guardian_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewGuardianController on _NewGuardianControllerBase, Store {
  Computed<PageProgressState> _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_NewGuardianControllerBase.loadState'))
      .value;

  final _$_fetchProgressAtom =
      Atom(name: '_NewGuardianControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, GuardianSessioEntity>> get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, GuardianSessioEntity>> value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_NewGuardianControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$currentStateAtom =
      Atom(name: '_NewGuardianControllerBase.currentState');

  @override
  GuardianState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(GuardianState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$loadPageAsyncAction =
      AsyncAction('_NewGuardianControllerBase.loadPage');

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
currentState: ${currentState},
loadState: ${loadState}
    ''';
  }
}
