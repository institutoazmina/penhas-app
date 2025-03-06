// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_center_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HelpCenterController on _HelpCenterControllerBase, Store {
  Computed<PageProgressState>? _$loadStateComputed;

  @override
  PageProgressState get loadState => (_$loadStateComputed ??=
          Computed<PageProgressState>(() => super.loadState,
              name: '_HelpCenterControllerBase.loadState'))
      .value;

  late final _$_alertProgressAtom =
      Atom(name: '_HelpCenterControllerBase._alertProgress', context: context);

  @override
  ObservableFuture<Either<Failure, AlertModel>>? get _alertProgress {
    _$_alertProgressAtom.reportRead();
    return super._alertProgress;
  }

  @override
  set _alertProgress(ObservableFuture<Either<Failure, AlertModel>>? value) {
    _$_alertProgressAtom.reportWrite(value, super._alertProgress, () {
      super._alertProgress = value;
    });
  }

  late final _$alertStateAtom =
      Atom(name: '_HelpCenterControllerBase.alertState', context: context);

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

  late final _$isLocationPermissionRequiredAtom = Atom(
      name: '_HelpCenterControllerBase.isLocationPermissionRequired',
      context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_HelpCenterControllerBase.errorMessage', context: context);

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

  late final _$triggerGuardianAsyncAction = AsyncAction(
      '_HelpCenterControllerBase.triggerGuardian',
      context: context);

  @override
  Future<void> triggerGuardian() {
    return _$triggerGuardianAsyncAction.run(() => super.triggerGuardian());
  }

  late final _$triggerCallPoliceAsyncAction = AsyncAction(
      '_HelpCenterControllerBase.triggerCallPolice',
      context: context);

  @override
  Future<void> triggerCallPolice() {
    return _$triggerCallPoliceAsyncAction.run(() => super.triggerCallPolice());
  }

  late final _$triggerAudioRecordAsyncAction = AsyncAction(
      '_HelpCenterControllerBase.triggerAudioRecord',
      context: context);

  @override
  Future<void> triggerAudioRecord() {
    return _$triggerAudioRecordAsyncAction
        .run(() => super.triggerAudioRecord());
  }

  late final _$checkLocalicationRequiredAsyncAction = AsyncAction(
      '_HelpCenterControllerBase.checkLocalicationRequired',
      context: context);

  @override
  Future<void> checkLocalicationRequired() {
    return _$checkLocalicationRequiredAsyncAction
        .run(() => super.checkLocalicationRequired());
  }

  late final _$_HelpCenterControllerBaseActionController =
      ActionController(name: '_HelpCenterControllerBase', context: context);

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
  void audios() {
    final _$actionInfo = _$_HelpCenterControllerBaseActionController
        .startAction(name: '_HelpCenterControllerBase.audios');
    try {
      return super.audios();
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
