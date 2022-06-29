import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/filters/domain/entities/filter_tag_entity.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_add_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';

part 'support_center_add_controller.g.dart';

class SupportCenterAddController extends _SupportCenterAddControllerBase
    with _$SupportCenterAddController {
  SupportCenterAddController({
    required SupportCenterUseCase supportCenterUseCase,
  }) : super(supportCenterUseCase);
}

abstract class _SupportCenterAddControllerBase with Store, MapFailureMessage {
  _SupportCenterAddControllerBase(this._supportCenterUseCase) {
    setup();
  }

  String? _address;
  String? _cep;
  String? _phone;
  String? _placeName;
  String? _placeDescription;
  FilterTagEntity? _category;
  String? _coverage;

  final SupportCenterUseCase _supportCenterUseCase;

  @observable
  ObservableFuture<Either<Failure, AlertModel>>? _savingSuggestion;

  @observable
  String addressError = '';

  @observable
  String placeNameError = '';

  @observable
  String placeDescriptionError = '';

  @observable
  String? errorMessage = '';

  @observable
  String cep = '';
  
  @observable
  String phone = '';

  @observable
  ObservableList<FilterTagEntity> places = ObservableList<FilterTagEntity>();

  @observable
  ObservableList<FilterTagEntity> coverage = ObservableList<FilterTagEntity>();

  @observable
  String categorySelected = '';

  @observable
  String coverageSelected = '';

  @observable
  String categoryError = '';

  @observable
  String coverageError = '';
  
  @observable
  String phoneError = '';

  @observable
  SupportCenterAddState state = const SupportCenterAddState.initial();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_savingSuggestion);
  }

  @observable
  GuardianAlertState alertState = const GuardianAlertState.initial();

  @action
  void setAddress(String address) {
    addressError = address.isNotEmpty ? '' : 'Endereço é campo obrigatório';
    _address = address;
  }

  @action
  void setPlaceName(String name) {
    placeNameError = name.isNotEmpty ? '' : 'Nome do ponto é campo obrigatório';
    _placeName = name;
  }

  @action
  void setPlaceDescription(String description) {
    placeDescriptionError =
        description.isNotEmpty ? '' : 'Nome do ponto é campo obrigatório';
    _placeDescription = description;
  }

  @action
  void setCategorie(String value) {
    categoryError = value.isNotEmpty ? '' : 'Categoria é campo obrigatório';
    _category = places.firstWhere((element) => element.id == value);
    categorySelected = _category!.id;
  }

  @action
  void setCoverage(String coverage) {
    coverageError = coverage.isNotEmpty ? '' : 'Abrangência é campo obrigatório';
    _coverage = coverage;
  }

  @action
  void setPhone(String phone) {
    phoneError = phone.isEmpty || phone.length < 8 ? 'Telefone é campo obrigatório' : '';
    _phone = phone;
  }

  @action
  void setCep(String cep) {
    _cep = cep;
  }


  @action
  Future<void> savePlace() async {
    resetErrors();

    if (_category == null) {
      categoryError = 'O tipo é um campo obrigatório';
    }

    if (_coverage == null) {
      coverageError = 'Abrangência é campo obrigatório';
    }

    if (_address == null || _address!.isEmpty) {
      addressError = 'Endereço é campo obrigatório';
    }

    if (_phone == null || _phone!.isEmpty) {
      phoneError = 'Phone é campo obrigatório';
    }

    if (_placeName == null || _placeName!.isEmpty) {
      placeNameError = 'Nome do ponto é campo obrigatório';
    }

    if (_placeDescription == null || _placeDescription!.isEmpty) {
      placeDescriptionError = 'Deixa uma descrição do ponto de apoio';
    }

    _savingSuggestion = ObservableFuture(
      _supportCenterUseCase.saveSuggestion(
        name: _placeName,
        address: _address,
        category: _category!.id,
        coverage: _coverage,
        description: _placeDescription,
        cep: _cep,
        phone: _phone,
      ),
    );

    final Either<Failure, AlertModel> result = await _savingSuggestion!;
    result.fold(
      (failure) => errorMessage = mapFailureMessage(failure),
      (valid) => handleSuccessAddSupportCenter(valid),
    );
  }

  void resetErrors() {
    addressError = '';
    placeNameError = '';
    phoneError = '';
    placeDescriptionError = '';
    errorMessage = '';
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
      (metadata) => handleCategoriesSuccess(metadata!.categories!),
    );
  }

  void handleCategoriesError(Failure failure) {
    state = SupportCenterAddState.error(mapFailureMessage(failure)!);
  }

  void handleCategoriesSuccess(List<FilterTagEntity> categories) {
    places = categories.asObservable();
    state = const SupportCenterAddState.loaded();
  }

  void handleSuccessAddSupportCenter(AlertModel field) {
    alertState = GuardianAlertState.alert(
      GuardianAlertMessageAction(
        title: field.title ?? 'Sugestão enviada',
        message: field.message,
        onPressed: () async => actionAfterNotice(),
      ),
    );
  }

  Future<void> actionAfterNotice() async {
    Modular.to.pop(true);
  }

  PageProgressState monitorProgress(ObservableFuture<Object>? observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }
}
