// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_stealth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInStealthController on _SignInStealthController, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignInStealthController.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_SignInStealthController._progress', context: context);

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

  late final _$userGreetingsAtom =
      Atom(name: '_SignInStealthController.userGreetings', context: context);

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
      Atom(name: '_SignInStealthController.userEmail', context: context);

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

  late final _$warningPasswordAtom =
      Atom(name: '_SignInStealthController.warningPassword', context: context);

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
      Atom(name: '_SignInStealthController.errorMessage', context: context);

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

  late final _$signAtom =
      Atom(name: '_SignInStealthController.sign', context: context);

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

  late final _$signListAtom =
      Atom(name: '_SignInStealthController.signList', context: context);

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

  late final _$isSecurityRunningAtom = Atom(
      name: '_SignInStealthController.isSecurityRunning', context: context);

  @override
  bool get isSecurityRunning {
    _$isSecurityRunningAtom.reportRead();
    return super.isSecurityRunning;
  }

  @override
  set isSecurityRunning(bool value) {
    _$isSecurityRunningAtom.reportWrite(value, super.isSecurityRunning, () {
      super.isSecurityRunning = value;
    });
  }

  late final _$signInWithEmailAndPasswordPressedAsyncAction = AsyncAction(
      '_SignInStealthController.signInWithEmailAndPasswordPressed',
      context: context);

  @override
  Future<void> signInWithEmailAndPasswordPressed() {
    return _$signInWithEmailAndPasswordPressedAsyncAction
        .run(() => super.signInWithEmailAndPasswordPressed());
  }

  late final _$changeAccountAsyncAction =
      AsyncAction('_SignInStealthController.changeAccount', context: context);

  @override
  Future<void> changeAccount() {
    return _$changeAccountAsyncAction.run(() => super.changeAccount());
  }

  late final _$resetPasswordPressedAsyncAction = AsyncAction(
      '_SignInStealthController.resetPasswordPressed',
      context: context);

  @override
  Future<void> resetPasswordPressed() {
    return _$resetPasswordPressedAsyncAction
        .run(() => super.resetPasswordPressed());
  }

  late final _$_SignInStealthControllerActionController =
      ActionController(name: '_SignInStealthController', context: context);

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
  void dispose() {
    final _$actionInfo = _$_SignInStealthControllerActionController.startAction(
        name: '_SignInStealthController.dispose');
    try {
      return super.dispose();
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
isSecurityRunning: ${isSecurityRunning},
currentState: ${currentState}
    ''';
  }
}
