// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_three_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordThreeController
    on _ResetPasswordThreeControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_ResetPasswordThreeControllerBase.currentState'))
      .value;

  late final _$_progressAtom = Atom(
      name: '_ResetPasswordThreeControllerBase._progress', context: context);

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
      name: '_ResetPasswordThreeControllerBase.errorMessage', context: context);

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

  late final _$warningPasswordAtom = Atom(
      name: '_ResetPasswordThreeControllerBase.warningPassword',
      context: context);

  @override
  String get warningPassword {
    _$warningPasswordAtom.reportRead();
    return super.warningPassword;
  }

  @override
  set warningPassword(String value) {
    _$warningPasswordAtom.reportWrite(value, super.warningPassword, () {
      super.warningPassword = value;
    });
  }

  late final _$warningConfirmationPasswordAtom = Atom(
      name: '_ResetPasswordThreeControllerBase.warningConfirmationPassword',
      context: context);

  @override
  String get warningConfirmationPassword {
    _$warningConfirmationPasswordAtom.reportRead();
    return super.warningConfirmationPassword;
  }

  @override
  set warningConfirmationPassword(String value) {
    _$warningConfirmationPasswordAtom
        .reportWrite(value, super.warningConfirmationPassword, () {
      super.warningConfirmationPassword = value;
    });
  }

  late final _$nextStepPressedAsyncAction = AsyncAction(
      '_ResetPasswordThreeControllerBase.nextStepPressed',
      context: context);

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  late final _$_ResetPasswordThreeControllerBaseActionController =
      ActionController(
          name: '_ResetPasswordThreeControllerBase', context: context);

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_ResetPasswordThreeControllerBaseActionController
        .startAction(name: '_ResetPasswordThreeControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_ResetPasswordThreeControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmationPassword(String password) {
    final _$actionInfo =
        _$_ResetPasswordThreeControllerBaseActionController.startAction(
            name: '_ResetPasswordThreeControllerBase.setConfirmationPassword');
    try {
      return super.setConfirmationPassword(password);
    } finally {
      _$_ResetPasswordThreeControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
warningPassword: ${warningPassword},
warningConfirmationPassword: ${warningConfirmationPassword},
currentState: ${currentState}
    ''';
  }
}
