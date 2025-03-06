// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpController on _SignUpControllerBase, Store {
  Computed<PageProgressState>? _$currentStateComputed;

  @override
  PageProgressState get currentState => (_$currentStateComputed ??=
          Computed<PageProgressState>(() => super.currentState,
              name: '_SignUpControllerBase.currentState'))
      .value;

  late final _$_progressAtom =
      Atom(name: '_SignUpControllerBase._progress', context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_SignUpControllerBase.errorMessage', context: context);

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

  late final _$warningFullnameAtom =
      Atom(name: '_SignUpControllerBase.warningFullname', context: context);

  @override
  String? get warningFullname {
    _$warningFullnameAtom.reportRead();
    return super.warningFullname;
  }

  @override
  set warningFullname(String? value) {
    _$warningFullnameAtom.reportWrite(value, super.warningFullname, () {
      super.warningFullname = value;
    });
  }

  late final _$warningBirthdayAtom =
      Atom(name: '_SignUpControllerBase.warningBirthday', context: context);

  @override
  String? get warningBirthday {
    _$warningBirthdayAtom.reportRead();
    return super.warningBirthday;
  }

  @override
  set warningBirthday(String? value) {
    _$warningBirthdayAtom.reportWrite(value, super.warningBirthday, () {
      super.warningBirthday = value;
    });
  }

  late final _$warningCpfAtom =
      Atom(name: '_SignUpControllerBase.warningCpf', context: context);

  @override
  String? get warningCpf {
    _$warningCpfAtom.reportRead();
    return super.warningCpf;
  }

  @override
  set warningCpf(String? value) {
    _$warningCpfAtom.reportWrite(value, super.warningCpf, () {
      super.warningCpf = value;
    });
  }

  late final _$warningCepAtom =
      Atom(name: '_SignUpControllerBase.warningCep', context: context);

  @override
  String? get warningCep {
    _$warningCepAtom.reportRead();
    return super.warningCep;
  }

  @override
  set warningCep(String? value) {
    _$warningCepAtom.reportWrite(value, super.warningCep, () {
      super.warningCep = value;
    });
  }

  late final _$nextStepPressedAsyncAction =
      AsyncAction('_SignUpControllerBase.nextStepPressed', context: context);

  @override
  Future<void> nextStepPressed() {
    return _$nextStepPressedAsyncAction.run(() => super.nextStepPressed());
  }

  late final _$_SignUpControllerBaseActionController =
      ActionController(name: '_SignUpControllerBase', context: context);

  @override
  void setFullname(String fullname) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.setFullname');
    try {
      return super.setFullname(fullname);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(String birthday) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.setBirthday');
    try {
      return super.setBirthday(birthday);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCpf(String cpf) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.setCpf');
    try {
      return super.setCpf(cpf);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCep(String cep) {
    final _$actionInfo = _$_SignUpControllerBaseActionController.startAction(
        name: '_SignUpControllerBase.setCep');
    try {
      return super.setCep(cep);
    } finally {
      _$_SignUpControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
warningFullname: ${warningFullname},
warningBirthday: ${warningBirthday},
warningCpf: ${warningCpf},
warningCep: ${warningCep},
currentState: ${currentState}
    ''';
  }
}
