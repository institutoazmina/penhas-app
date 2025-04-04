// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_anonymous_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInAnonymousController on SignInAnonymousControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: 'SignInAnonymousControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: 'SignInAnonymousControllerBase._progress', context: context);

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

  late final _$userGreetingsAtom = Atom(
      name: 'SignInAnonymousControllerBase.userGreetings', context: context);

  @override
  String get userGreetings {
    _$userGreetingsAtom.reportRead();
    return super.userGreetings;
  }

  @override
  set userGreetings(String value) {
    _$userGreetingsAtom.reportWrite(value, super.userGreetings, () {
      super.userGreetings = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: 'SignInAnonymousControllerBase.userEmail', context: context);

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$warningPasswordAtom = Atom(
      name: 'SignInAnonymousControllerBase.warningPassword', context: context);

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

  late final _$errorMessageAtom = Atom(
      name: 'SignInAnonymousControllerBase.errorMessage', context: context);

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
      'SignInAnonymousControllerBase.signInWithEmailAndPasswordPressed',
      context: context);

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  late final _$changeAccountAsyncAction = AsyncAction(
      'SignInAnonymousControllerBase.changeAccount',
      context: context);

  @override
  Future<void> changeAccount() {
    return _$changeAccountAsyncAction.run(() => super.changeAccount());
  }

  late final _$resetPasswordPressedAsyncAction = AsyncAction(
      'SignInAnonymousControllerBase.resetPasswordPressed',
      context: context);

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  late final _$SignInAnonymousControllerBaseActionController =
      ActionController(name: 'SignInAnonymousControllerBase', context: context);

  @override
  void setPassword(String password) {
    final _$actionInfo = _$SignInAnonymousControllerBaseActionController
        .startAction(name: 'SignInAnonymousControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$SignInAnonymousControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userGreetings: ${userGreetings},
userEmail: ${userEmail},
warningPassword: ${warningPassword},
errorMessage: ${errorMessage},
currentState: ${currentState}
    ''';
  }
}
