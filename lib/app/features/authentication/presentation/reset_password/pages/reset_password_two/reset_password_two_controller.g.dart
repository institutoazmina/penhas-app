// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordTwoController on _ResetPasswordTwoControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_ResetPasswordTwoControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_ResetPasswordTwoControllerBase._progress', context: context);

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

  late final _$errorMessageAtom = Atom(
      name: '_ResetPasswordTwoControllerBase.errorMessage', context: context);

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

  late final _$warrningTokenAtom = Atom(
      name: '_ResetPasswordTwoControllerBase.warrningToken', context: context);

  @override
  String get warrningToken {
    _$warrningTokenAtom.reportRead();
    return super.warrningToken;
  }

  @override
  set warrningToken(String value) {
    _$warrningTokenAtom.reportWrite(value, super.warrningToken, () {
      super.warrningToken = value;
    });
  }

  late final _$setTokenAsyncAction =
      AsyncAction('_ResetPasswordTwoControllerBase.setToken', context: context);

  @override
  Future<void> setToken(String token) {
    return _$setTokenAsyncAction.run(() => super.setToken(token));
  }

  late final _$nextStepPressedAsyncAction = AsyncAction(
      '_ResetPasswordTwoControllerBase.nextStepPressed',
      context: context);

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
warrningToken: ${warrningToken},
currentState: ${currentState}
    ''';
  }
}
