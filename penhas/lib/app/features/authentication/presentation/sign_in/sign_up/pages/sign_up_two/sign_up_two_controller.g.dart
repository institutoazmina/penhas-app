// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_two_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpTwoController on _SignUpTwoControllerBase, Store {
  final _$_progressAtom = Atom(name: '_SignUpTwoControllerBase._progress');

  @override
  ObservableFuture<Either<Failure, ValidField>> get _progress {
    _$_progressAtom.context.enforceReadPolicy(_$_progressAtom);
    _$_progressAtom.reportObserved();
    return super._progress;
  }

  @override
  set _progress(ObservableFuture<Either<Failure, ValidField>> value) {
    _$_progressAtom.context.conditionallyRunInAction(() {
      super._progress = value;
      _$_progressAtom.reportChanged();
    }, _$_progressAtom, name: '${_$_progressAtom.name}_set');
  }

  final _$warningNicknameAtom =
      Atom(name: '_SignUpTwoControllerBase.warningNickname');

  @override
  String get warningNickname {
    _$warningNicknameAtom.context.enforceReadPolicy(_$warningNicknameAtom);
    _$warningNicknameAtom.reportObserved();
    return super.warningNickname;
  }

  @override
  set warningNickname(String value) {
    _$warningNicknameAtom.context.conditionallyRunInAction(() {
      super.warningNickname = value;
      _$warningNicknameAtom.reportChanged();
    }, _$warningNicknameAtom, name: '${_$warningNicknameAtom.name}_set');
  }

  final _$warningGenreAtom =
      Atom(name: '_SignUpTwoControllerBase.warningGenre');

  @override
  String get warningGenre {
    _$warningGenreAtom.context.enforceReadPolicy(_$warningGenreAtom);
    _$warningGenreAtom.reportObserved();
    return super.warningGenre;
  }

  @override
  set warningGenre(String value) {
    _$warningGenreAtom.context.conditionallyRunInAction(() {
      super.warningGenre = value;
      _$warningGenreAtom.reportChanged();
    }, _$warningGenreAtom, name: '${_$warningGenreAtom.name}_set');
  }

  final _$warningRaceAtom = Atom(name: '_SignUpTwoControllerBase.warningRace');

  @override
  String get warningRace {
    _$warningRaceAtom.context.enforceReadPolicy(_$warningRaceAtom);
    _$warningRaceAtom.reportObserved();
    return super.warningRace;
  }

  @override
  set warningRace(String value) {
    _$warningRaceAtom.context.conditionallyRunInAction(() {
      super.warningRace = value;
      _$warningRaceAtom.reportChanged();
    }, _$warningRaceAtom, name: '${_$warningRaceAtom.name}_set');
  }

  final _$currentGenreAtom =
      Atom(name: '_SignUpTwoControllerBase.currentGenre');

  @override
  String get currentGenre {
    _$currentGenreAtom.context.enforceReadPolicy(_$currentGenreAtom);
    _$currentGenreAtom.reportObserved();
    return super.currentGenre;
  }

  @override
  set currentGenre(String value) {
    _$currentGenreAtom.context.conditionallyRunInAction(() {
      super.currentGenre = value;
      _$currentGenreAtom.reportChanged();
    }, _$currentGenreAtom, name: '${_$currentGenreAtom.name}_set');
  }

  final _$currentRaceAtom = Atom(name: '_SignUpTwoControllerBase.currentRace');

  @override
  String get currentRace {
    _$currentRaceAtom.context.enforceReadPolicy(_$currentRaceAtom);
    _$currentRaceAtom.reportObserved();
    return super.currentRace;
  }

  @override
  set currentRace(String value) {
    _$currentRaceAtom.context.conditionallyRunInAction(() {
      super.currentRace = value;
      _$currentRaceAtom.reportChanged();
    }, _$currentRaceAtom, name: '${_$currentRaceAtom.name}_set');
  }

  final _$errorMessageAtom =
      Atom(name: '_SignUpTwoControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$nextStepPressedAsyncAction = AsyncAction('nextStepPressed');

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  final _$_SignUpTwoControllerBaseActionController =
      ActionController(name: '_SignUpTwoControllerBase');

  @override
  void setNickname(String name) {
    final _$actionInfo =
        _$_SignUpTwoControllerBaseActionController.startAction();
    try {
      return super.setNickname(name);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGenre(String label) {
    final _$actionInfo =
        _$_SignUpTwoControllerBaseActionController.startAction();
    try {
      return super.setGenre(label);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRace(String label) {
    final _$actionInfo =
        _$_SignUpTwoControllerBaseActionController.startAction();
    try {
      return super.setRace(label);
    } finally {
      _$_SignUpTwoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'warningNickname: ${warningNickname.toString()},warningGenre: ${warningGenre.toString()},warningRace: ${warningRace.toString()},currentGenre: ${currentGenre.toString()},currentRace: ${currentRace.toString()},errorMessage: ${errorMessage.toString()}';
    return '{$string}';
  }
}
