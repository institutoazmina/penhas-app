import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
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
  ObservableFuture<Either<Failure, ValidField>> _savingSuggestion;

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
  String categorySelected = "";

  @observable
  String categoryError = "";

  @observable
  SupportCenterAddState state = SupportCenterAddState.initial();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_savingSuggestion);
  }

  @observable
  GuardianAlertState alertState = GuardianAlertState.initial();

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
    placeDescriptionError =
        description.isNotEmpty ? "" : "Nome do ponto é campo obrigatório";
    _placeDescription = description;
  }

  @action
  void setCategorie(String value) {
    categoryError = value.isNotEmpty ? "" : "Nome do ponto é campo obrigatório";
    _category = places.firstWhere((element) => element.id == value);
    categorySelected = _category.id;
  }

  @action
  Future<void> savePlace() async {
    resetErrors();
    setMessageErro("");

    if (_category == null) {
      categoryError = "O tipo é um campo obrigatório";
    }

    if (_address == null || _address.isEmpty) {
      addressError = "Endereço é campo obrigatório";
    }

    if (_placeName == null || _placeName.isEmpty) {
      placeNameError = "Nome do ponto é campo obrigatório";
    }

    if (_placeDescription == null || _placeDescription.isEmpty) {
      placeDescriptionError = "Deixa uma descrição do ponto de apoio";
    }

    _savingSuggestion = ObservableFuture(_supportCenterUseCase.saveSuggestion(
      name: _placeName,
      address: _address,
      category: _category.id,
      description: _placeDescription,
    ));

    final result = await _savingSuggestion;
    result.fold(
      (failure) => setMessageErro(mapFailureMessage(failure)),
      (valid) => handleSuccessAddSupportCenter(valid),
    );
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
    final result = await _supportCenterUseCase.metadata();

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

  void handleSuccessAddSupportCenter(ValidField field) {
    alertState = GuardianAlertState.alert(
      GuardianAlertMessageAction(
        message: field.message,
        onPressed: () async => actionAfterNotice(),
      ),
    );
  }

  void actionAfterNotice() async {
    Modular.to.pop(true);
  }

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }
}
