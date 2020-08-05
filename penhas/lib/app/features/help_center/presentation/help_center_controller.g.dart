// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_center_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HelpCenterController on _HelpCenterControllerBase, Store {
  Computed<PageProgressState> _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_HelpCenterControllerBase.loadState'))
      .value;

  final _$_alertProgressAtom =
      Atom(name: '_HelpCenterControllerBase._alertProgress');

  @override
  ObservableFuture<Either<Failure, ValidField>> get _alertProgress {
    _$_alertProgressAtom.reportRead();
    return super._alertProgress;
  }

  @override
  set _alertProgress(ObservableFuture<Either<Failure, ValidField>> value) {
    _$_alertProgressAtom.reportWrite(value, super._alertProgress, () {
      super._alertProgress = value;
    });
  }

  final _$alertStateAtom = Atom(name: '_HelpCenterControllerBase.alertState');

  @override
  HelpCenterState get alertState {
    _$alertStateAtom.reportRead();
    return super.alertState;
  }

  @override
  set alertState(HelpCenterState value) {
    _$alertStateAtom.reportWrite(value, super.alertState, () {
      super.alertState = value;
    });
  }

  final _$isLocationPermissionRequiredAtom =
      Atom(name: '_HelpCenterControllerBase.isLocationPermissionRequired');

  @override
  bool get isLocationPermissionRequired {
    _$isLocationPermissionRequiredAtom.reportRead();
    return super.isLocationPermissionRequired;
  }

  @override
  set isLocationPermissionRequired(bool value) {
    _$isLocationPermissionRequiredAtom
        .reportWrite(value, super.isLocationPermissionRequired, () {
      super.isLocationPermissionRequired = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_HelpCenterControllerBase.errorMessage');

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

  final _$triggerGuardianAsyncAction =
      AsyncAction('_HelpCenterControllerBase.triggerGuardian');

  @override
  Future<void> triggerGuardian() {
    return _$triggerGuardianAsyncAction.run(() => super.triggerGuardian());
  }

  final _$checkLocalicationRequiredAsyncAction =
      AsyncAction('_HelpCenterControllerBase.checkLocalicationRequired');

  @override
  Future<void> checkLocalicationRequired() {
    return _$checkLocalicationRequiredAsyncAction
        .run(() => super.checkLocalicationRequired());
  }

  final _$_HelpCenterControllerBaseActionController =
      ActionController(name: '_HelpCenterControllerBase');

  @override
  void newGuardian() {
    final _$actionInfo = _$_HelpCenterControllerBaseActionController
        .startAction(name: '_HelpCenterControllerBase.newGuardian');
    try {
      return super.newGuardian();
    } finally {
      _$_HelpCenterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void guardians() {
    final _$actionInfo = _$_HelpCenterControllerBaseActionController
        .startAction(name: '_HelpCenterControllerBase.guardians');
    try {
      return super.guardians();
    } finally {
      _$_HelpCenterControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
alertState: ${alertState},
isLocationPermissionRequired: ${isLocationPermissionRequired},
errorMessage: ${errorMessage},
loadState: ${loadState}
    ''';
  }
}
