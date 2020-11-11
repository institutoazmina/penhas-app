import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/filters/states/filter_action_observer.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

part 'support_center_controller.g.dart';

class SupportCenterController extends _SupportCenterControllerBase
    with _$SupportCenterController {
  SupportCenterController({
    @required SupportCenterUseCase supportCenterUseCase,
  }) : super(supportCenterUseCase);
}

abstract class _SupportCenterControllerBase with Store, MapFailureMessage {
  List<FilterTagEntity> _tags = List<FilterTagEntity>();
  SupportCenterPlaceSessionEntity currentPlaceSession;
  var _fetchRequest = SupportCenterFetchRequest();

  final SupportCenterUseCase _supportCenterUseCase;

  _SupportCenterControllerBase(this._supportCenterUseCase) {
    setup();
  }

  @observable
  ObservableFuture<Either<Failure, SupportCenterMetadataEntity>>
      _loadCategories;

  @observable
  ObservableFuture<Either<Failure, SupportCenterPlaceSessionEntity>>
      _loadSupportCenter;

  @observable
  int categoriesSelected = 0;

  @observable
  String errorMessage = "";

  @observable
  ObservableSet<Marker> placeMarkers = ObservableSet<Marker>();

  @observable
  LatLng initialPosition = LatLng(0, 0);

  @observable
  SupportCenterState state = SupportCenterState.loaded();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_loadSupportCenter);
  }

  @action
  Future<void> onFilterAction() async {
    setMessageErro("");
    _loadCategories = ObservableFuture(_supportCenterUseCase.metadata());

    final result = await _loadCategories;

    result.fold(
      (failure) => handleCategoriesError(failure),
      (metadata) async => handleCategoriesSuccess(metadata.categories),
    );
  }

  @action
  Future<void> onKeywordsAction(String keywords) async {
    _fetchRequest = _fetchRequest.copyWith(keywords: keywords);

    await loadSupportCenter(_fetchRequest);
  }

  @action
  Future<void> addPlace() async {
    Modular.to.pushNamed("/mainboard/supportcenter/add");
  }

  @action
  Future<void> listPlaces() async {
    Modular.to.pushNamed(
      "/mainboard/supportcenter/list",
      arguments: currentPlaceSession,
    );
  }

  @action
  Future<void> location() async {
    Modular.to
        .pushNamed("/mainboard/supportcenter/location")
        .then((value) async => handleLocationFeedback(value));
  }

  @action
  Future<void> placeDetail() async {
    Modular.to.pushNamed("/mainboard/supportcenter/show");
  }

  @action
  Future<void> retry() async {
    await loadSupportCenter(_fetchRequest);
  }
}

extension _SupportCenterControllerBasePrivate on _SupportCenterControllerBase {
  Future<void> setup() async {
    await loadSupportCenter(_fetchRequest);
  }

  void setMessageErro(String message) {
    errorMessage = message;
  }

  Future<void> handleLocationFeedback(Object value) async {
    if (value is bool && value == true) {
      await loadSupportCenter(_fetchRequest);
    }
  }

  Future<void> handleCategoriesSuccess(List<FilterTagEntity> categories) async {
    final tags = categories
        .map(
          (e) => FilterTagEntity(
            id: e.id,
            isSelected: isSeleted(e.id),
            label: e.label,
          ),
        )
        .toList();

    Modular.to
        .pushNamed("/mainboard/filters", arguments: tags)
        .then((v) => v as FilterActionObserver)
        .then((v) async => handleCategoriesUpdate(v));
  }

  void handleCategoriesError(Failure failure) {
    final message = mapFailureMessage(failure);
    setMessageErro(message);
  }

  bool isSeleted(String id) {
    try {
      _tags.firstWhere((v) => v.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> handleCategoriesUpdate(FilterActionObserver action) async {
    if (action == null) {
      return;
    }

    _tags = action.when(
      reset: () => List<FilterTagEntity>(),
      updated: (listTags) => listTags,
    );

    final categories = _tags.map((e) => e.id).toList();
    _fetchRequest = _fetchRequest.copyWith(categories: categories);
    categoriesSelected = _tags.length;

    await loadSupportCenter(_fetchRequest);
  }

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  Future<void> loadSupportCenter(SupportCenterFetchRequest fetchRequest) async {
    setErrorMessage("");
    _loadSupportCenter = ObservableFuture(
      _supportCenterUseCase.fetch(
        fetchRequest,
      ),
    );

    final result = await _loadSupportCenter;

    result.fold(
      (failure) => handleStateError(failure),
      (places) => handleLoadSupportCenterSuccess(places),
    );
  }

  void handleLoadSupportCenterSuccess(
      SupportCenterPlaceSessionEntity session) async {
    state = SupportCenterState.loaded();
    currentPlaceSession = session;
    initialPosition = LatLng(session.latitude, session.longitude);
    final places = session.places.map((e) => buildMarker(e));

    if (places.isEmpty) {
      setErrorMessage(
          "Não encontramos Pontos de Apoio, verifique a localização e os filtros.");
    }

    placeMarkers = Set<Marker>.from(places).asObservable();
  }

  void handleStateError(Failure f) {
    if (f is GpsFailure) {
      state = SupportCenterState.gpsError(f.message);
      return;
    }

    state = SupportCenterState.error(mapFailureMessage(f));
  }

  Marker buildMarker(SupportCenterPlaceEntity place) {
    final LatLng makerPosition = LatLng(place.latitude, place.longitude);
    final placeColor = HSLColor.fromColor(
      DesignSystemColors.hexColor(
        place.category.color,
      ),
    );

    return Marker(
      position: makerPosition,
      markerId: MarkerId(makerPosition.toString()),
      infoWindow: InfoWindow(
        title: place.name,
        onTap: () {
          print('ola muito feliz mundo!');
        },
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(placeColor.hue),
    );
  }

  void setErrorMessage(String msg) {
    errorMessage = msg;
  }
}
