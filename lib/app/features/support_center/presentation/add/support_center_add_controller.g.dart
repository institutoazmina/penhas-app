// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterAddController on _SupportCenterAddControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterAddControllerBase.progressState'))
      .value;

  final _$_savingSuggestionAtom =
      Atom(name: '_SupportCenterAddControllerBase._savingSuggestion');

  @override
  ObservableFuture<Either<Failure, AlertModel>>? get _savingSuggestion {
    _$_savingSuggestionAtom.reportRead();
    return super._savingSuggestion;
  }

  @override
  set _savingSuggestion(ObservableFuture<Either<Failure, AlertModel>>? value) {
    _$_savingSuggestionAtom.reportWrite(value, super._savingSuggestion, () {
      super._savingSuggestion = value;
    });
  }

  final _$addressErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.addressError');

  @override
  String get addressError {
    _$addressErrorAtom.reportRead();
    return super.addressError;
  }

  @override
  set addressError(String value) {
    _$addressErrorAtom.reportWrite(value, super.addressError, () {
      super.addressError = value;
    });
  }

  final _$placeNameErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.placeNameError');

  @override
  String get placeNameError {
    _$placeNameErrorAtom.reportRead();
    return super.placeNameError;
  }

  @override
  set placeNameError(String value) {
    _$placeNameErrorAtom.reportWrite(value, super.placeNameError, () {
      super.placeNameError = value;
    });
  }

  final _$placeDescriptionErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.placeDescriptionError');

  @override
  String get placeDescriptionError {
    _$placeDescriptionErrorAtom.reportRead();
    return super.placeDescriptionError;
  }

  @override
  set placeDescriptionError(String value) {
    _$placeDescriptionErrorAtom.reportWrite(value, super.placeDescriptionError,
        () {
      super.placeDescriptionError = value;
    });
  }

  final _$cityErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.cityError');

  @override
  String get cityError {
    _$cityErrorAtom.reportRead();
    return super.cityError;
  }

  @override
  set cityError(String value) {
    _$cityErrorAtom.reportWrite(value, super.cityError, () {
      super.cityError = value;
    });
  }

  final _$ufSelectedAtom =
      Atom(name: '_SupportCenterAddControllerBase.ufSelected');

  @override
  String get ufSelected {
    _$ufSelectedAtom.reportRead();
    return super.ufSelected;
  }

  @override
  set ufSelected(String value) {
    _$ufSelectedAtom.reportWrite(value, super.ufSelected, () {
      super.ufSelected = value;
    });
  }

  final _$is24hSelectedAtom =
      Atom(name: '_SupportCenterAddControllerBase.is24hSelected');

  @override
  String get is24hSelected {
    _$is24hSelectedAtom.reportRead();
    return super.is24hSelected;
  }

  @override
  set is24hSelected(String value) {
    _$is24hSelectedAtom.reportWrite(value, super.is24hSelected, () {
      super.is24hSelected = value;
    });
  }

  final _$hasWhatsAppSelectedAtom =
      Atom(name: '_SupportCenterAddControllerBase.hasWhatsAppSelected');

  @override
  String get hasWhatsAppSelected {
    _$hasWhatsAppSelectedAtom.reportRead();
    return super.hasWhatsAppSelected;
  }

  @override
  set hasWhatsAppSelected(String value) {
    _$hasWhatsAppSelectedAtom.reportWrite(value, super.hasWhatsAppSelected, () {
      super.hasWhatsAppSelected = value;
    });
  }

  final _$ddd1ErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.ddd1Error');

  @override
  String get ddd1Error {
    _$ddd1ErrorAtom.reportRead();
    return super.ddd1Error;
  }

  @override
  set ddd1Error(String value) {
    _$ddd1ErrorAtom.reportWrite(value, super.ddd1Error, () {
      super.ddd1Error = value;
    });
  }

  final _$phone1ErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.phone1Error');

  @override
  String get phone1Error {
    _$phone1ErrorAtom.reportRead();
    return super.phone1Error;
  }

  @override
  set phone1Error(String value) {
    _$phone1ErrorAtom.reportWrite(value, super.phone1Error, () {
      super.phone1Error = value;
    });
  }

  final _$ddd2ErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.ddd2Error');

  @override
  String get ddd2Error {
    _$ddd2ErrorAtom.reportRead();
    return super.ddd2Error;
  }

  @override
  set ddd2Error(String value) {
    _$ddd2ErrorAtom.reportWrite(value, super.ddd2Error, () {
      super.ddd2Error = value;
    });
  }

  final _$phone2ErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.phone2Error');

  @override
  String get phone2Error {
    _$phone2ErrorAtom.reportRead();
    return super.phone2Error;
  }

  @override
  set phone2Error(String value) {
    _$phone2ErrorAtom.reportWrite(value, super.phone2Error, () {
      super.phone2Error = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_SupportCenterAddControllerBase.errorMessage');

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

  final _$placesAtom = Atom(name: '_SupportCenterAddControllerBase.places');

  @override
  ObservableList<FilterTagEntity> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableList<FilterTagEntity> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  final _$coverageAtom = Atom(name: '_SupportCenterAddControllerBase.coverage');

  @override
  ObservableList<FilterTagEntity> get coverage {
    _$coverageAtom.reportRead();
    return super.coverage;
  }

  @override
  set coverage(ObservableList<FilterTagEntity> value) {
    _$coverageAtom.reportWrite(value, super.coverage, () {
      super.coverage = value;
    });
  }

  final _$categorySelectedAtom =
      Atom(name: '_SupportCenterAddControllerBase.categorySelected');

  @override
  String get categorySelected {
    _$categorySelectedAtom.reportRead();
    return super.categorySelected;
  }

  @override
  set categorySelected(String value) {
    _$categorySelectedAtom.reportWrite(value, super.categorySelected, () {
      super.categorySelected = value;
    });
  }

  final _$coverageSelectedAtom =
      Atom(name: '_SupportCenterAddControllerBase.coverageSelected');

  @override
  String get coverageSelected {
    _$coverageSelectedAtom.reportRead();
    return super.coverageSelected;
  }

  @override
  set coverageSelected(String value) {
    _$coverageSelectedAtom.reportWrite(value, super.coverageSelected, () {
      super.coverageSelected = value;
    });
  }

  final _$categoryErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.categoryError');

  @override
  String get categoryError {
    _$categoryErrorAtom.reportRead();
    return super.categoryError;
  }

  @override
  set categoryError(String value) {
    _$categoryErrorAtom.reportWrite(value, super.categoryError, () {
      super.categoryError = value;
    });
  }

  final _$coverageErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.coverageError');

  @override
  String get coverageError {
    _$coverageErrorAtom.reportRead();
    return super.coverageError;
  }

  @override
  set coverageError(String value) {
    _$coverageErrorAtom.reportWrite(value, super.coverageError, () {
      super.coverageError = value;
    });
  }

  final _$cepErrorAtom = Atom(name: '_SupportCenterAddControllerBase.cepError');

  @override
  String get cepError {
    _$cepErrorAtom.reportRead();
    return super.cepError;
  }

  @override
  set cepError(String value) {
    _$cepErrorAtom.reportWrite(value, super.cepError, () {
      super.cepError = value;
    });
  }

  final _$emailErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.emailError');

  @override
  String get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  final _$numberErrorAtom =
      Atom(name: '_SupportCenterAddControllerBase.numberError');

  @override
  String get numberError {
    _$numberErrorAtom.reportRead();
    return super.numberError;
  }

  @override
  set numberError(String value) {
    _$numberErrorAtom.reportWrite(value, super.numberError, () {
      super.numberError = value;
    });
  }

  final _$ufErrorAtom = Atom(name: '_SupportCenterAddControllerBase.ufError');

  @override
  String get ufError {
    _$ufErrorAtom.reportRead();
    return super.ufError;
  }

  @override
  set ufError(String value) {
    _$ufErrorAtom.reportWrite(value, super.ufError, () {
      super.ufError = value;
    });
  }

  final _$stateAtom = Atom(name: '_SupportCenterAddControllerBase.state');

  @override
  SupportCenterAddState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SupportCenterAddState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$alertStateAtom =
      Atom(name: '_SupportCenterAddControllerBase.alertState');

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

  final _$savePlaceAsyncAction =
      AsyncAction('_SupportCenterAddControllerBase.savePlace');

  @override
  Future<void> savePlace() {
    return _$savePlaceAsyncAction.run(() => super.savePlace());
  }

  final _$_SupportCenterAddControllerBaseActionController =
      ActionController(name: '_SupportCenterAddControllerBase');

  @override
  void setAddress(String address) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setAddress');
    try {
      return super.setAddress(address);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPlaceName(String name) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setPlaceName');
    try {
      return super.setPlaceName(name);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setObservation(String observation) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setObservation');
    try {
      return super.setObservation(observation);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String value) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCoverage(String coverage) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setCoverage');
    try {
      return super.setCoverage(coverage);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUf(String uf) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setUf');
    try {
      return super.setUf(uf);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIs24h(String value) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setIs24h');
    try {
      return super.setIs24h(value);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasWhatsApp(String value) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setHasWhatsApp');
    try {
      return super.setHasWhatsApp(value);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDdd1(String ddd1) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setDdd1');
    try {
      return super.setDdd1(ddd1);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDdd2(String ddd2) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setDdd2');
    try {
      return super.setDdd2(ddd2);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone1(String phone1) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setPhone1');
    try {
      return super.setPhone1(phone1);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone2(String phone2) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setPhone2');
    try {
      return super.setPhone2(phone2);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String checkPhone(String currentPhone, String ddd) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.checkPhone');
    try {
      return super.checkPhone(currentPhone, ddd);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCep(String cep) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setCep');
    try {
      return super.setCep(cep);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComplement(String complement) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setComplement');
    try {
      return super.setComplement(complement);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeighborhood(String neighborhood) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setNeighborhood');
    try {
      return super.setNeighborhood(neighborhood);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCity(String city) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setCity');
    try {
      return super.setCity(city);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumber(String number) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setNumber');
    try {
      return super.setNumber(number);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String email) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHour(String hour) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setHour');
    try {
      return super.setHour(hour);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
addressError: ${addressError},
placeNameError: ${placeNameError},
placeDescriptionError: ${placeDescriptionError},
cityError: ${cityError},
ufSelected: ${ufSelected},
is24hSelected: ${is24hSelected},
hasWhatsAppSelected: ${hasWhatsAppSelected},
ddd1Error: ${ddd1Error},
phone1Error: ${phone1Error},
ddd2Error: ${ddd2Error},
phone2Error: ${phone2Error},
errorMessage: ${errorMessage},
places: ${places},
coverage: ${coverage},
categorySelected: ${categorySelected},
coverageSelected: ${coverageSelected},
categoryError: ${categoryError},
coverageError: ${coverageError},
cepError: ${cepError},
emailError: ${emailError},
numberError: ${numberError},
ufError: ${ufError},
state: ${state},
alertState: ${alertState},
progressState: ${progressState}
    ''';
  }
}
