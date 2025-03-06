// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SupportCenterController on _SupportCenterControllerBase, Store {
  Computed<PageProgressState>? _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterControllerBase.progressState'))
      .value;

  late final _$_loadCategoriesAtom = Atom(
      name: '_SupportCenterControllerBase._loadCategories', context: context);

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

  late final _$_loadSupportCenterAtom = Atom(
      name: '_SupportCenterControllerBase._loadSupportCenter',
      context: context);

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

  late final _$categoriesSelectedAtom = Atom(
      name: '_SupportCenterControllerBase.categoriesSelected',
      context: context);

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

  late final _$errorMessageAtom =
      Atom(name: '_SupportCenterControllerBase.errorMessage', context: context);

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

  late final _$placeMarkersAtom =
      Atom(name: '_SupportCenterControllerBase.placeMarkers', context: context);

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

  late final _$latLngBoundsAtom =
      Atom(name: '_SupportCenterControllerBase.latLngBounds', context: context);

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

  late final _$useLatLngBoundsAtom = Atom(
      name: '_SupportCenterControllerBase.useLatLngBounds', context: context);

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

  late final _$initialPositionAtom = Atom(
      name: '_SupportCenterControllerBase.initialPosition', context: context);

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

  late final _$stateAtom =
      Atom(name: '_SupportCenterControllerBase.state', context: context);

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

  late final _$currentKeywordsAtom = Atom(
      name: '_SupportCenterControllerBase.currentKeywords', context: context);

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

  late final _$onFilterActionAsyncAction = AsyncAction(
      '_SupportCenterControllerBase.onFilterAction',
      context: context);

  @override
  Future<void> onFilterAction() {
    return _$onFilterActionAsyncAction.run(() => super.onFilterAction());
  }

  late final _$onKeywordsActionAsyncAction = AsyncAction(
      '_SupportCenterControllerBase.onKeywordsAction',
      context: context);

  @override
  Future<void> onKeywordsAction(String keywords) {
    return _$onKeywordsActionAsyncAction
        .run(() => super.onKeywordsAction(keywords));
  }

  late final _$addPlaceAsyncAction =
      AsyncAction('_SupportCenterControllerBase.addPlace', context: context);

  @override
  Future<void> addPlace() {
    return _$addPlaceAsyncAction.run(() => super.addPlace());
  }

  late final _$listPlacesAsyncAction =
      AsyncAction('_SupportCenterControllerBase.listPlaces', context: context);

  @override
  Future<void> listPlaces() {
    return _$listPlacesAsyncAction.run(() => super.listPlaces());
  }

  late final _$locationAsyncAction =
      AsyncAction('_SupportCenterControllerBase.location', context: context);

  @override
  Future<void> location() {
    return _$locationAsyncAction.run(() => super.location());
  }

  late final _$placeDetailAsyncAction =
      AsyncAction('_SupportCenterControllerBase.placeDetail', context: context);

  @override
  Future<void> placeDetail() {
    return _$placeDetailAsyncAction.run(() => super.placeDetail());
  }

  late final _$retryAsyncAction =
      AsyncAction('_SupportCenterControllerBase.retry', context: context);

  @override
  Future<void> retry() {
    return _$retryAsyncAction.run(() => super.retry());
  }

  late final _$requestLocationAsyncAction = AsyncAction(
      '_SupportCenterControllerBase.requestLocation',
      context: context);

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
