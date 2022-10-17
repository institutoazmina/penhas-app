// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardians_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GuardiansController on _GuardiansControllerBase, Store {
  Computed<PageProgressState>? _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_GuardiansControllerBase.loadState'))
      .value;
  Computed<PageProgressState>? _$updateStateComputed;

  @override
  PageProgressState get updateState => (_$updateStateComputed ??=
          Computed<PageProgressState>(() => super.updateState,
              name: '_GuardiansControllerBase.updateState'))
      .value;

  final _$_fetchProgressAtom =
      Atom(name: '_GuardiansControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, GuardianSessioEntity>>? get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, GuardianSessioEntity>>? value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$_updateProgressAtom =
      Atom(name: '_GuardiansControllerBase._updateProgress');

  @override
  ObservableFuture<Either<Failure, dynamic>>? get _updateProgress {
    _$_updateProgressAtom.reportRead();
    return super._updateProgress;
  }

  @override
  set _updateProgress(ObservableFuture<Either<Failure, dynamic>>? value) {
    _$_updateProgressAtom.reportWrite(value, super._updateProgress, () {
      super._updateProgress = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_GuardiansControllerBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$currentStateAtom =
      Atom(name: '_GuardiansControllerBase.currentState');

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
      AsyncAction('_GuardiansControllerBase.loadPage');

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
currentState: ${currentState},
loadState: ${loadState},
updateState: ${updateState}
    ''';
  }
}
