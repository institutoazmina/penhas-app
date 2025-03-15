// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInController on SignInControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: 'SignInControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: 'SignInControllerBase._progress', context: context);

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

  late final _$warningEmailAtom =
      Atom(name: 'SignInControllerBase.warningEmail', context: context);

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

  late final _$warningPasswordAtom =
      Atom(name: 'SignInControllerBase.warningPassword', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: 'SignInControllerBase.errorMessage', context: context);

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

  late final _$signInWithEmailAndPasswordPressedAsyncAction = AsyncAction(
      'SignInControllerBase.signInWithEmailAndPasswordPressed',
      context: context);

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  late final _$registerUserPressedAsyncAction =
      AsyncAction('SignInControllerBase.registerUserPressed', context: context);

  @override
  Future<void> registerUserPressed() {
    return _$registerUserPressedAsyncAction
        .run(() => super.registerUserPressed());
  }

  late final _$resetPasswordPressedAsyncAction = AsyncAction(
      'SignInControllerBase.resetPasswordPressed',
      context: context);

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  late final _$SignInControllerBaseActionController =
      ActionController(name: 'SignInControllerBase', context: context);

  @override
  void setEmail(String address) {
    final _$actionInfo = _$SignInControllerBaseActionController.startAction(
        name: 'SignInControllerBase.setEmail');
    try {
      return super.setEmail(address);
    } finally {
      _$SignInControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$SignInControllerBaseActionController.startAction(
        name: 'SignInControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$SignInControllerBaseActionController.endAction(_$actionInfo);
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
