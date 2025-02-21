// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_guardian_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewGuardianController on _NewGuardianControllerBase, Store {
  Computed<PageProgressState>? _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_NewGuardianControllerBase.loadState'))
      .value;
  Computed<PageProgressState>? _$createStateComputed;

  @override
  PageProgressState get createState => (_$createStateComputed ??=
          Computed<PageProgressState>(() => super.createState,
              name: '_NewGuardianControllerBase.createState'))
      .value;

  final _$_fetchProgressAtom =
      Atom(name: '_NewGuardianControllerBase._fetchProgress');

  @override
  ObservableFuture<Either<Failure, GuardianSessionEntity>>? get _fetchProgress {
    _$_fetchProgressAtom.reportRead();
    return super._fetchProgress;
  }

  @override
  set _fetchProgress(
      ObservableFuture<Either<Failure, GuardianSessionEntity>>? value) {
    _$_fetchProgressAtom.reportWrite(value, super._fetchProgress, () {
      super._fetchProgress = value;
    });
  }

  final _$_createProgressAtom =
      Atom(name: '_NewGuardianControllerBase._createProgress');

  @override
  ObservableFuture<Either<Failure, AlertModel>>? get _createProgress {
    _$_createProgressAtom.reportRead();
    return super._createProgress;
  }

  @override
  set _createProgress(ObservableFuture<Either<Failure, AlertModel>>? value) {
    _$_createProgressAtom.reportWrite(value, super._createProgress, () {
      super._createProgress = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_NewGuardianControllerBase.errorMessage');

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

  final _$warningMobileAtom =
      Atom(name: '_NewGuardianControllerBase.warningMobile');

  @override
  String get warningMobile {
    _$warningMobileAtom.reportRead();
    return super.warningMobile;
  }

  @override
  set warningMobile(String value) {
    _$warningMobileAtom.reportWrite(value, super.warningMobile, () {
      super.warningMobile = value;
    });
  }

  final _$warningNameAtom =
      Atom(name: '_NewGuardianControllerBase.warningName');

  @override
  String get warningName {
    _$warningNameAtom.reportRead();
    return super.warningName;
  }

  @override
  set warningName(String value) {
    _$warningNameAtom.reportWrite(value, super.warningName, () {
      super.warningName = value;
    });
  }

  final _$currentStateAtom =
      Atom(name: '_NewGuardianControllerBase.currentState');

  @override
  NewGuardianState get currentState {
    _$currentStateAtom.reportRead();
    return super.currentState;
  }

  @override
  set currentState(NewGuardianState value) {
    _$currentStateAtom.reportWrite(value, super.currentState, () {
      super.currentState = value;
    });
  }

  final _$alertStateAtom = Atom(name: '_NewGuardianControllerBase.alertState');

  @override
  GuardianAlertState get alertState {
    _$alertStateAtom.reportRead();
    return super.alertState;
  }

  @override
  set alertState(GuardianAlertState value) {
    _$alertStateAtom.reportWrite(value, super.alertState, () {
      super.alertState = value;
    });
  }

  final _$loadPageAsyncAction =
      AsyncAction('_NewGuardianControllerBase.loadPage');

  @override
  Future<void> loadPage() {
    return _$loadPageAsyncAction.run(() => super.loadPage());
  }

  final _$addGuardianAsyncAction =
      AsyncAction('_NewGuardianControllerBase.addGuardian');

  @override
  Future<void> addGuardian() {
    return _$addGuardianAsyncAction.run(() => super.addGuardian());
  }

  final _$_NewGuardianControllerBaseActionController =
      ActionController(name: '_NewGuardianControllerBase');

  @override
  void setGuardianName(String name) {
    final _$actionInfo = _$_NewGuardianControllerBaseActionController
        .startAction(name: '_NewGuardianControllerBase.setGuardianName');
    try {
      return super.setGuardianName(name);
    } finally {
      _$_NewGuardianControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGuardianMobile(String mobile) {
    final _$actionInfo = _$_NewGuardianControllerBaseActionController
        .startAction(name: '_NewGuardianControllerBase.setGuardianMobile');
    try {
      return super.setGuardianMobile(mobile);
    } finally {
      _$_NewGuardianControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
warningMobile: ${warningMobile},
warningName: ${warningName},
currentState: ${currentState},
alertState: ${alertState},
loadState: ${loadState},
createState: ${createState}
    ''';
  }
}
