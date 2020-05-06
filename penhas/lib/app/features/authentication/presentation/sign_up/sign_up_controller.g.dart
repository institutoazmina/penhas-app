// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpController on _SignUpControllerBase, Store {
  Computed<StoreState> _$currentStateComputed;

  @override
  StoreState get currentState => (_$currentStateComputed ??=
          Computed<StoreState>(() => super.currentState))
      .value;

  final _$_progressAtom = Atom(name: '_SignUpControllerBase._progress');

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

  final _$errorMessageAtom = Atom(name: '_SignUpControllerBase.errorMessage');

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

  final _$warningFullnameAtom =
      Atom(name: '_SignUpControllerBase.warningFullname');

  @override
  String get warningFullname {
    _$warningFullnameAtom.context.enforceReadPolicy(_$warningFullnameAtom);
    _$warningFullnameAtom.reportObserved();
    return super.warningFullname;
  }

  @override
  set warningFullname(String value) {
    _$warningFullnameAtom.context.conditionallyRunInAction(() {
      super.warningFullname = value;
      _$warningFullnameAtom.reportChanged();
    }, _$warningFullnameAtom, name: '${_$warningFullnameAtom.name}_set');
  }

  final _$warningBirthdayAtom =
      Atom(name: '_SignUpControllerBase.warningBirthday');

  @override
  String get warningBirthday {
    _$warningBirthdayAtom.context.enforceReadPolicy(_$warningBirthdayAtom);
    _$warningBirthdayAtom.reportObserved();
    return super.warningBirthday;
  }

  @override
  set warningBirthday(String value) {
    _$warningBirthdayAtom.context.conditionallyRunInAction(() {
      super.warningBirthday = value;
      _$warningBirthdayAtom.reportChanged();
    }, _$warningBirthdayAtom, name: '${_$warningBirthdayAtom.name}_set');
  }

  final _$warningCpfAtom = Atom(name: '_SignUpControllerBase.warningCpf');

  @override
  String get warningCpf {
    _$warningCpfAtom.context.enforceReadPolicy(_$warningCpfAtom);
    _$warningCpfAtom.reportObserved();
    return super.warningCpf;
  }

  @override
  set warningCpf(String value) {
    _$warningCpfAtom.context.conditionallyRunInAction(() {
      super.warningCpf = value;
      _$warningCpfAtom.reportChanged();
    }, _$warningCpfAtom, name: '${_$warningCpfAtom.name}_set');
  }

  final _$warningCepAtom = Atom(name: '_SignUpControllerBase.warningCep');

  @override
  String get warningCep {
    _$warningCepAtom.context.enforceReadPolicy(_$warningCepAtom);
    _$warningCepAtom.reportObserved();
    return super.warningCep;
  }

  @override
  set warningCep(String value) {
    _$warningCepAtom.context.conditionallyRunInAction(() {
      super.warningCep = value;
      _$warningCepAtom.reportChanged();
    }, _$warningCepAtom, name: '${_$warningCepAtom.name}_set');
  }

  final _$nextStepPressedAsyncAction = AsyncAction('nextStepPressed');

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  final _$_SignUpControllerBaseActionController =
      ActionController(name: '_SignUpControllerBase');

  @override
  void setFullname(String fullname) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setFullname(fullname);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(DateTime birthday) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setBirthday(birthday);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCpf(String cpf) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setCpf(cpf);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCep(String cep) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction();
    try {
      return super.setCep(cep);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'errorMessage: ${errorMessage.toString()},warningFullname: ${warningFullname.toString()},warningBirthday: ${warningBirthday.toString()},warningCpf: ${warningCpf.toString()},warningCep: ${warningCep.toString()},currentState: ${currentState.toString()}';
    return '{$string}';
  }
}
