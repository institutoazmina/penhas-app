import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_metadata_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_add_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

part 'support_center_add_controller.g.dart';

class SupportCenterAddController extends _SupportCenterAddControllerBase
    with _$SupportCenterAddController {
  SupportCenterAddController({
    @required SupportCenterUseCase supportCenterUseCase,
  }) : super(supportCenterUseCase);
}

abstract class _SupportCenterAddControllerBase with Store, MapFailureMessage {
  String _address;
  String _placeName;
  String _placeDescription;
  FilterTagEntity _category;

  final SupportCenterUseCase _supportCenterUseCase;

  _SupportCenterAddControllerBase(this._supportCenterUseCase) {
    setup();
  }

  @observable
  ObservableFuture<Either<Failure, SupportCenterMetadataEntity>>
      _loadCategories;

  @observable
  String addressError = "";

  @observable
  String placeNameError = "";

  @observable
  String placeDescriptionError = "";

  @observable
  String errorMessage = "";

  @observable
  ObservableList<FilterTagEntity> places = ObservableList<FilterTagEntity>();

  @observable
  String categorieName = "";

  @observable
  SupportCenterAddState state = SupportCenterAddState.initial();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_loadCategories);
  }

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void setAddress(String address) {
    addressError = address.isNotEmpty ? "" : "Endereço é campo obrigatório";
    _address = address;
  }

  @action
  void setPlaceName(String name) {
    placeNameError = name.isNotEmpty ? "" : "Nome do ponto é campo obrigatório";
    _placeName = name;
  }

  @action
  void setPlaceDescription(String description) {
    _placeDescription = description;
  }

  @action
  void setCategorie(String value) {
    _category = places.firstWhere((element) => element.id == value);
    categorieName = _category.label;
  }

  @action
  void salvePlace() {
    resetErrors();

    if (_address == null || _address.isEmpty) {
      addressError = "Endereço é campo obrigatório";
    }

    if (_placeName == null || _placeName.isEmpty) {
      placeNameError = "Nome do ponto é campo obrigatório";
    }

    if (_placeDescription == null || _placeDescription.isEmpty) {
      placeDescriptionError = "Deixa uma descrição do ponto de apoio";
    }
  }

  void resetErrors() {
    addressError = "";
    placeNameError = "";
    placeDescriptionError = "";
  }
}

extension _Private on _SupportCenterAddControllerBase {
  Future<void> setup() async {
    await loadCategorias();
  }

  Future<void> loadCategorias() async {
    _loadCategories = ObservableFuture(_supportCenterUseCase.metadata());

    final result = await _loadCategories;

    result.fold(
      (failure) => handleCategoriesError(failure),
      (metadata) => handleCategoriesSuccess(metadata.categories),
    );
  }

  void handleCategoriesError(Failure failure) {
    state = SupportCenterAddState.error(mapFailureMessage(failure));
  }

  void handleCategoriesSuccess(List<FilterTagEntity> categories) {
    places = categories.asObservable();
    state = SupportCenterAddState.loaded();
  }

  void setMessageErro(String message) {
    errorMessage = message;
  }
}
