// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deleted_account_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DeletedAccountController on _DeletedAccountControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_DeletedAccountControllerBase.progressState'))
      .value;

  final _$_progressAtom = Atom(name: '_DeletedAccountControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, ValidField>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_DeletedAccountControllerBase.errorMessage');

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

  final _$reactiveAsyncAction =
      AsyncAction('_DeletedAccountControllerBase.reactive');

  @override
  Future<void> reactive() {
    return _$reactiveAsyncAction.run(() => super.reactive());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
progressState: ${progressState}
    ''';
  }
}
