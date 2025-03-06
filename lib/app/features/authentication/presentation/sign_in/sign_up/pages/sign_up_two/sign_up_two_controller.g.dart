// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpTwoController on _SignUpTwoControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignUpTwoControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_SignUpTwoControllerBase._progress', context: context);

  @override
  ObservableFuture<Either<Failure, ValidField>>? get _progress {
    _$_progressAtom.reportRead();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>>? value) {
    _$_progressAtom.reportWrite(value, super._progress, () {
      super._progress = value;
    });
  }

  late final _$warningNicknameAtom =
      Atom(name: '_SignUpTwoControllerBase.warningNickname', context: context);

  @override
  String get warningNickname {
    _$warningNicknameAtom.reportRead();
    return super.warningNickname;
  }

  @override
  set warningNickname(String value) {
    _$warningNicknameAtom.reportWrite(value, super.warningNickname, () {
      super.warningNickname = value;
    });
  }

  late final _$warningSocialNameAtom = Atom(
      name: '_SignUpTwoControllerBase.warningSocialName', context: context);

  @override
  String get warningSocialName {
    _$warningSocialNameAtom.reportRead();
    return super.warningSocialName;
  }

  @override
  set warningSocialName(String value) {
    _$warningSocialNameAtom.reportWrite(value, super.warningSocialName, () {
      super.warningSocialName = value;
    });
  }

  late final _$warningGenreAtom =
      Atom(name: '_SignUpTwoControllerBase.warningGenre', context: context);

  @override
  String get warningGenre {
    _$warningGenreAtom.reportRead();
    return super.warningGenre;
  }

  @override
  set warningGenre(String value) {
    _$warningGenreAtom.reportWrite(value, super.warningGenre, () {
      super.warningGenre = value;
    });
  }

  late final _$warningRaceAtom =
      Atom(name: '_SignUpTwoControllerBase.warningRace', context: context);

  @override
  String get warningRace {
    _$warningRaceAtom.reportRead();
    return super.warningRace;
  }

  @override
  set warningRace(String value) {
    _$warningRaceAtom.reportWrite(value, super.warningRace, () {
      super.warningRace = value;
    });
  }

  late final _$currentGenreAtom =
      Atom(name: '_SignUpTwoControllerBase.currentGenre', context: context);

  @override
  String get currentGenre {
    _$currentGenreAtom.reportRead();
    return super.currentGenre;
  }

  @override
  set currentGenre(String value) {
    _$currentGenreAtom.reportWrite(value, super.currentGenre, () {
      super.currentGenre = value;
    });
  }

  late final _$currentRaceAtom =
      Atom(name: '_SignUpTwoControllerBase.currentRace', context: context);

  @override
  String get currentRace {
    _$currentRaceAtom.reportRead();
    return super.currentRace;
  }

  @override
  set currentRace(String value) {
    _$currentRaceAtom.reportWrite(value, super.currentRace, () {
      super.currentRace = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SignUpTwoControllerBase.errorMessage', context: context);

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

  late final _$hasSocialNameFieldAtom = Atom(
      name: '_SignUpTwoControllerBase.hasSocialNameField', context: context);

  @override
  bool get hasSocialNameField {
    _$hasSocialNameFieldAtom.reportRead();
    return super.hasSocialNameField;
  }

  @override
  set hasSocialNameField(bool value) {
    _$hasSocialNameFieldAtom.reportWrite(value, super.hasSocialNameField, () {
      super.hasSocialNameField = value;
    });
  }

  late final _$nextStepPressedAsyncAction =
      AsyncAction('_SignUpTwoControllerBase.nextStepPressed', context: context);

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  late final _$_SignUpTwoControllerBaseActionController =
      ActionController(name: '_SignUpTwoControllerBase', context: context);

  @override
  void setNickname(String name) {
    final _$actionInfo = _$_SignUpTwoControllerBaseActionController.startAction(
        name: '_SignUpTwoControllerBase.setNickname');
    try {
      return super.setNickname(name);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSocialName(String name) {
    final _$actionInfo = _$_SignUpTwoControllerBaseActionController.startAction(
        name: '_SignUpTwoControllerBase.setSocialName');
    try {
      return super.setSocialName(name);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGenre(String? label) {
    final _$actionInfo = _$_SignUpTwoControllerBaseActionController.startAction(
        name: '_SignUpTwoControllerBase.setGenre');
    try {
      return super.setGenre(label);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRace(String? label) {
    final _$actionInfo = _$_SignUpTwoControllerBaseActionController.startAction(
        name: '_SignUpTwoControllerBase.setRace');
    try {
      return super.setRace(label);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
warningNickname: ${warningNickname},
warningSocialName: ${warningSocialName},
warningGenre: ${warningGenre},
warningRace: ${warningRace},
currentGenre: ${currentGenre},
currentRace: ${currentRace},
errorMessage: ${errorMessage},
hasSocialNameField: ${hasSocialNameField},
currentState: ${currentState}
    ''';
  }
}
