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

  final _$_loadCategoriesAtom =
      Atom(name: '_SupportCenterAddControllerBase._loadCategories');

  @override
  ObservableFuture<Either<Failure, SupportCenterMetadataEntity>>
      get _loadCategories {
    _$_loadCategoriesAtom.reportRead();
    return super._loadCategories;
  }

  @override
  set _loadCategories(
      ObservableFuture<Either<Failure, SupportCenterMetadataEntity>> value) {
    _$_loadCategoriesAtom.reportWrite(value, super._loadCategories, () {
      super._loadCategories = value;
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

  final _$categorieNameAtom =
      Atom(name: '_SupportCenterAddControllerBase.categorieName');

  @override
  String get categorieName {
    _$categorieNameAtom.reportRead();
    return super.categorieName;
  }

  @override
  set categorieName(String value) {
    _$categorieNameAtom.reportWrite(value, super.categorieName, () {
      super.categorieName = value;
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
  void salvePlace() {
    final _$actionInfo = _$_SupportCenterAddControllerBaseActionController
        .startAction(name: '_SupportCenterAddControllerBase.salvePlace');
    try {
      return super.salvePlace();
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
categorieName: ${categorieName},
state: ${state},
progressState: ${progressState}
    ''';
  }
}
