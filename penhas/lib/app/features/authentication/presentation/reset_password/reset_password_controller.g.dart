// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetPasswordController on _ResetPasswordControllerBase, Store {
  Computed<StoreState> _$currentStateComputed;

  @override
  StoreState get currentState =>
      (_$currentStateComputed ??= Computed<StoreState>(() => super.currentState,
              name: '_ResetPasswordControllerBase.currentState'))
          .value;

  final _$_progressAtom = Atom(name: '_ResetPasswordControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, ResetPasswordResponseEntity>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(
      ObservableFuture<Either<Failure, ResetPasswordResponseEntity>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_ResetPasswordControllerBase.errorMessage');

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

  final _$warningEmailAtom =
      Atom(name: '_ResetPasswordControllerBase.warningEmail');

  @override
  String get warningEmail {
    _$warningEmailAtom.reportRead();
    return super.warningEmail;
  }

  @override
  set warningEmail(String value) {
    _$warningEmailAtom.reportWrite(value, super.warningEmail, () {
      super.warningEmail = value;
    });
  }

  final _$nextStepPressedAsyncAction =
      AsyncAction('_ResetPasswordControllerBase.nextStepPressed');

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  final _$_ResetPasswordControllerBaseActionController =
      ActionController(name: '_ResetPasswordControllerBase');

  @override
  void setEmail(String address) {
    final _$actionInfo = _$_ResetPasswordControllerBaseActionController
        .startAction(name: '_ResetPasswordControllerBase.setEmail');
    try {
      return super.setEmail(address);
    } finally {
      _$_ResetPasswordControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
warningEmail: ${warningEmail},
currentState: ${currentState}
    ''';
  }
}
