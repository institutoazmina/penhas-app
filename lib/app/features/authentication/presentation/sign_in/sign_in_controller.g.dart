// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInController on _SignInControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignInControllerBase.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_SignInControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, SessionEntity>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, SessionEntity>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$warningEmailAtom = Atom(name: '_SignInControllerBase.warningEmail');

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

  final _$warningPasswordAtom =
      Atom(name: '_SignInControllerBase.warningPassword');

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

  final _$errorMessageAtom = Atom(name: '_SignInControllerBase.errorMessage');

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

  final _$signInWithEmailAndPasswordPressedAsyncAction =
      AsyncAction('_SignInControllerBase.signInWithEmailAndPasswordPressed');

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  final _$registerUserPressedAsyncAction =
      AsyncAction('_SignInControllerBase.registerUserPressed');

  @override
  Future<void> registerUserPressed() {
    return _$registerUserPressedAsyncAction
        .run(() => super.registerUserPressed());
  }

  final _$resetPasswordPressedAsyncAction =
      AsyncAction('_SignInControllerBase.resetPasswordPressed');

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  final _$_SignInControllerBaseActionController =
      ActionController(name: '_SignInControllerBase');

  @override
  void setEmail(String address) {
    final _$actionInfo = _$_SignInControllerBaseActionController.startAction(
        name: '_SignInControllerBase.setEmail');
    try {
      return super.setEmail(address);
    } finally {
      _$_SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_SignInControllerBaseActionController.startAction(
        name: '_SignInControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
warningEmail: ${warningEmail},
warningPassword: ${warningPassword},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
