// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_add_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterAddController on _SupportCenterAddControllerBase, Store {
  Computed<PageProgressState> _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterAddControllerBase.progressState'))
      .value;

  final _$_savingSuggestionAtom =
      Atom(name: '_SupportCenterAddControllerBase._savingSuggestion');

  @override
  ObservableFuture<Either<Failure, AlertModel>> get _savingSuggestion {
    _$_savingSuggestionAtom.reportRead();
    return super._savingSuggestion;
  }

  @override
  set _savingSuggestion(ObservableFuture<Either<Failure, AlertModel>> value) {
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

  final _$errorMessageAtom =
      Atom(name: '_SupportCenterAddControllerBase.errorMessage');

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
  void setPlaceDescription(String description) {
    final _$actionInfo =
        _$_SupportCenterAddControllerBaseActionController.startAction(
            name: '_SupportCenterAddControllerBase.setPlaceDescription');
    try {
      return super.setPlaceDescription(description);
    } finally {
      _$_SupportCenterAddControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategorie(String value) {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.setCategorie');
    try {
      return super.setCategorie(value);
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
errorMessage: ${errorMessage},
places: ${places},
categorySelected: ${categorySelected},
categoryError: ${categoryError},
state: ${state},
alertState: ${alertState},
progressState: ${progressState}
    ''';
  }
}
