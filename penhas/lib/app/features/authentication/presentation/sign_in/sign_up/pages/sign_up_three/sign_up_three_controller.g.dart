// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_three_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpThreeController on _SignUpThreeControllerBase, Store {
  Computed<PageProgressState> _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignUpThreeControllerBase.currentState'))
      .value;

  final _$_progressAtom = Atom(name: '_SignUpThreeControllerBase._progress');

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

  final _$warningEmailAtom =
      Atom(name: '_SignUpThreeControllerBase.warningEmail');

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
      Atom(name: '_SignUpThreeControllerBase.warningPassword');

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
      Atom(name: '_SignUpThreeControllerBase.errorMessage');

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

  final _$registerUserPressAsyncAction =
      AsyncAction('_SignUpThreeControllerBase.registerUserPress');

  @override
  Future<void> registerUserPress() {
    return _$registerUserPressAsyncAction.run(() => super.registerUserPress());
  }

  final _$_SignUpThreeControllerBaseActionController =
      ActionController(name: '_SignUpThreeControllerBase');

  @override
  void setEmail(String email) {
    final _$actionInfo = _$_SignUpThreeControllerBaseActionController
        .startAction(name: '_SignUpThreeControllerBase.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$_SignUpThreeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$_SignUpThreeControllerBaseActionController
        .startAction(name: '_SignUpThreeControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_SignUpThreeControllerBaseActionController.endAction(_$actionInfo);
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
