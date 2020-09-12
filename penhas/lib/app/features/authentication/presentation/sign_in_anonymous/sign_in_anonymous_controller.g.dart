// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_anonymous_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInAnonymousController on _SignInAnonymousController, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignInAnonymousController.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_SignInAnonymousController._progress');

  @override
  ObservableFuture<Either<Failure, SessionEntity>> get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, SessionEntity>> value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  final _$userGreetingsAtom =
      Atom(name: '_SignInAnonymousController.userGreetings');

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

  final _$userEmailAtom = Atom(name: '_SignInAnonymousController.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$warningPasswordAtom =
      Atom(name: '_SignInAnonymousController.warningPassword');

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

  final _$errorMessageAtom =
      Atom(name: '_SignInAnonymousController.errorMessage');

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

  final _$signInWithEmailAndPasswordPressedAsyncAction = AsyncAction(
      '_SignInAnonymousController.signInWithEmailAndPasswordPressed');

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  final _$changeAccountAsyncAction =
      AsyncAction('_SignInAnonymousController.changeAccount');

  @override
  Future<void> changeAccount() {
    return _$changeAccountAsyncAction.run(() => super.changeAccount());
  }

  final _$resetPasswordPressedAsyncAction =
      AsyncAction('_SignInAnonymousController.resetPasswordPressed');

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  final _$_SignInAnonymousControllerActionController =
      ActionController(name: '_SignInAnonymousController');

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_SignInAnonymousControllerActionController
        .startAction(name: '_SignInAnonymousController.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_SignInAnonymousControllerActionController.endAction(_$actionInfo);
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
