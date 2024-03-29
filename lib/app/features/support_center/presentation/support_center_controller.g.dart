// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterController on _SupportCenterControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterControllerBase.progressState'))
      .value;

  final _$_loadCategoriesAtom =
      Atom(name: '_SupportCenterControllerBase._loadCategories');

  @override
  ObservableFuture<Either<Failure, SupportCenterMetadataEntity?>>?
      get _loadCategories {
    _$_loadCategoriesAtom.reportRead();
    return super._loadCategories;
  }

  @override
  set _loadCategories(
      ObservableFuture<Either<Failure, SupportCenterMetadataEntity?>>? value) {
    _$_loadCategoriesAtom.reportWrite(value, super._loadCategories, () {
      super._loadCategories = value;
    });
  }

  final _$_loadSupportCenterAtom =
      Atom(name: '_SupportCenterControllerBase._loadSupportCenter');

  @override
  ObservableFuture<Either<Failure, SupportCenterPlaceSessionEntity>>?
      get _loadSupportCenter {
    _$_loadSupportCenterAtom.reportRead();
    return super._loadSupportCenter;
  }

  @override
  set _loadSupportCenter(
      ObservableFuture<Either<Failure, SupportCenterPlaceSessionEntity>>?
          value) {
    _$_loadSupportCenterAtom.reportWrite(value, super._loadSupportCenter, () {
      super._loadSupportCenter = value;
    });
  }

  final _$categoriesSelectedAtom =
      Atom(name: '_SupportCenterControllerBase.categoriesSelected');

  @override
  int get categoriesSelected {
    _$categoriesSelectedAtom.reportRead();
    return super.categoriesSelected;
  }

  @override
  set categoriesSelected(int value) {
    _$categoriesSelectedAtom.reportWrite(value, super.categoriesSelected, () {
      super.categoriesSelected = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_SupportCenterControllerBase.errorMessage');

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

  final _$placeMarkersAtom =
      Atom(name: '_SupportCenterControllerBase.placeMarkers');

  @override
  ObservableSet<Marker> get placeMarkers {
    _$placeMarkersAtom.reportRead();
    return super.placeMarkers;
  }

  @override
  set placeMarkers(ObservableSet<Marker> value) {
    _$placeMarkersAtom.reportWrite(value, super.placeMarkers, () {
      super.placeMarkers = value;
    });
  }

  final _$latLngBoundsAtom =
      Atom(name: '_SupportCenterControllerBase.latLngBounds');

  @override
  LatLngBounds get latLngBounds {
    _$latLngBoundsAtom.reportRead();
    return super.latLngBounds;
  }

  @override
  set latLngBounds(LatLngBounds value) {
    _$latLngBoundsAtom.reportWrite(value, super.latLngBounds, () {
      super.latLngBounds = value;
    });
  }

  final _$useLatLngBoundsAtom =
      Atom(name: '_SupportCenterControllerBase.useLatLngBounds');

  @override
  bool get useLatLngBounds {
    _$useLatLngBoundsAtom.reportRead();
    return super.useLatLngBounds;
  }

  @override
  set useLatLngBounds(bool value) {
    _$useLatLngBoundsAtom.reportWrite(value, super.useLatLngBounds, () {
      super.useLatLngBounds = value;
    });
  }

  final _$initialPositionAtom =
      Atom(name: '_SupportCenterControllerBase.initialPosition');

  @override
  LatLng get initialPosition {
    _$initialPositionAtom.reportRead();
    return super.initialPosition;
  }

  @override
  set initialPosition(LatLng value) {
    _$initialPositionAtom.reportWrite(value, super.initialPosition, () {
      super.initialPosition = value;
    });
  }

  final _$stateAtom = Atom(name: '_SupportCenterControllerBase.state');

  @override
  SupportCenterState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SupportCenterState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$currentKeywordsAtom =
      Atom(name: '_SupportCenterControllerBase.currentKeywords');

  @override
  String get currentKeywords {
    _$currentKeywordsAtom.reportRead();
    return super.currentKeywords;
  }

  @override
  set currentKeywords(String value) {
    _$currentKeywordsAtom.reportWrite(value, super.currentKeywords, () {
      super.currentKeywords = value;
    });
  }

  final _$onFilterActionAsyncAction =
      AsyncAction('_SupportCenterControllerBase.onFilterAction');

  @override
  Future<void> onFilterAction() {
    return _$onFilterActionAsyncAction.run(() => super.onFilterAction());
  }

  final _$onKeywordsActionAsyncAction =
      AsyncAction('_SupportCenterControllerBase.onKeywordsAction');

  @override
  Future<void> onKeywordsAction(String keywords) {
    return _$onKeywordsActionAsyncAction
        .run(() => super.onKeywordsAction(keywords));
  }

  final _$addPlaceAsyncAction =
      AsyncAction('_SupportCenterControllerBase.addPlace');

  @override
  Future<void> addPlace() {
    return _$addPlaceAsyncAction.run(() => super.addPlace());
  }

  final _$listPlacesAsyncAction =
      AsyncAction('_SupportCenterControllerBase.listPlaces');

  @override
  Future<void> listPlaces() {
    return _$listPlacesAsyncAction.run(() => super.listPlaces());
  }

  final _$locationAsyncAction =
      AsyncAction('_SupportCenterControllerBase.location');

  @override
  Future<void> location() {
    return _$locationAsyncAction.run(() => super.location());
  }

  final _$placeDetailAsyncAction =
      AsyncAction('_SupportCenterControllerBase.placeDetail');

  @override
  Future<void> placeDetail() {
    return _$placeDetailAsyncAction.run(() => super.placeDetail());
  }

  final _$retryAsyncAction = AsyncAction('_SupportCenterControllerBase.retry');

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  final _$requestLocationAsyncAction =
      AsyncAction('_SupportCenterControllerBase.requestLocation');

  @override
  Future<void> requestLocation(void Function(LatLng) callback) {
    return _$requestLocationAsyncAction
        .run(() => super.requestLocation(callback));
  }

  @override
  String toString() {
    return '''
categoriesSelected: ${categoriesSelected},
errorMessage: ${errorMessage},
placeMarkers: ${placeMarkers},
latLngBounds: ${latLngBounds},
useLatLngBounds: ${useLatLngBounds},
initialPosition: ${initialPosition},
state: ${state},
currentKeywords: ${currentKeywords},
progressState: ${progressState}
    ''';
  }
}
