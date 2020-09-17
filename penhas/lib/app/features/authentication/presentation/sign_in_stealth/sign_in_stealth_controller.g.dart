// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_stealth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignInStealthController on _SignInStealthController, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignInStealthController.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_SignInStealthController._progress');

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
      Atom(name: '_SignInStealthController.userGreetings');

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

  final _$userEmailAtom = Atom(name: '_SignInStealthController.userEmail');

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
      Atom(name: '_SignInStealthController.warningPassword');

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
      Atom(name: '_SignInStealthController.errorMessage');

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

  final _$signAtom = Atom(name: '_SignInStealthController.sign');

  @override
  IZodiac get sign {
    _$signAtom.reportRead();
    return super.sign;
  }

  @override
  set sign(IZodiac value) {
    _$signAtom.reportWrite(value, super.sign, () {
      super.sign = value;
    });
  }

  final _$signListAtom = Atom(name: '_SignInStealthController.signList');

  @override
  ObservableList<IZodiac> get signList {
    _$signListAtom.reportRead();
    return super.signList;
  }

  @override
  set signList(ObservableList<IZodiac> value) {
    _$signListAtom.reportWrite(value, super.signList, () {
      super.signList = value;
    });
  }

  final _$signInWithEmailAndPasswordPressedAsyncAction =
      AsyncAction('_SignInStealthController.signInWithEmailAndPasswordPressed');

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  final _$changeAccountAsyncAction =
      AsyncAction('_SignInStealthController.changeAccount');

  @override
  Future<void> changeAccount() {
    return _$changeAccountAsyncAction.run(() => super.changeAccount());
  }

  final _$resetPasswordPressedAsyncAction =
      AsyncAction('_SignInStealthController.resetPasswordPressed');

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  final _$_SignInStealthControllerActionController =
      ActionController(name: '_SignInStealthController');

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_SignInStealthControllerActionController.startAction(
        name: '_SignInStealthController.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_SignInStealthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stealthAction() {
    final _$actionInfo = _$_SignInStealthControllerActionController.startAction(
        name: '_SignInStealthController.stealthAction');
    try {
      return super.stealthAction();
    } finally {
      _$_SignInStealthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userGreetings: ${userGreetings},
userEmail: ${userEmail},
warningPassword: ${warningPassword},
errorMessage: ${errorMessage},
sign: ${sign},
signList: ${signList},
currentState: ${currentState}
    ''';
  }
}
