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
  String _cep = '';
  String _email = '';
  String? _placeName;
  FilterTagEntity? _category;
  String? _coverage;
  String? _observation = '';
  String? _complement = '';
  String? _neighborhood = '';
  String? _city;
  String? _uf;
  String _hour = '';
  String? _number;
  String _phone1 = '';
  String _ddd1 = '';
  String _phone2 = '';
  String _ddd2 = '';
  String? _is24h = '';
  String? _hasWhatsapp = '';

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
  String cityError = '';

  @observable
  String ufSelected = '';

  @observable
  String is24hSelected = '';

  @observable
  String hasWhatsappSelected = '';

  @observable
  String ddd1Error = '';

  @observable
  String phone1Error = '';

  @observable
  String ddd2Error = '';

  @observable
  String phone2Error = '';

  @observable
  String? errorMessage = '';

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
  String cepError = '';
  
  @observable
  String emailError = '';

  @observable
  String numberError = '';

  @observable
  String ufError = '';

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
    addressError = address.isNotEmpty ? '' : 'Logradouro ?? campo obrigat??rio';
    _address = address;
  }

  @action
  void setPlaceName(String name) {
    placeNameError = name.isNotEmpty ? '' : 'Nome do ponto ?? campo obrigat??rio';
    _placeName = name;
  }

  @action
  void setObservation(String observation) {
    _observation = observation;
  }

  @action
  void setCategory(String value) {
    categoryError = value.isNotEmpty ? '' : 'Categoria ?? campo obrigat??rio';
    _category = places.firstWhere((element) => element.id == value);
    categorySelected = _category!.id;
  }

  @action
  void setCoverage(String coverage) {
    coverageError =
        coverage.isNotEmpty ? '' : 'Abrang??ncia ?? campo obrigat??rio';
    _coverage = coverage;
  }

  @action
  void setUf(String uf) {
    ufError = uf.isNotEmpty ? '' : 'Estado ?? campo obrigat??rio';
    _uf = uf;
  }

  @action
  void setIs24h(String value) {
    _is24h = value;
  }

  @action
  void setHasWhasapp(String value) {
    _hasWhatsapp = value;
  }

  @action
  void setDdd1(String ddd1) {
    ddd1Error = checkDdd(ddd1);
    _ddd1 = ddd1;
    setPhone1(_phone1);
  }

  @action
  void setDdd2(String ddd2) {
    ddd2Error = checkDdd(ddd2);
    _ddd2 = ddd2;
    setPhone2(_phone2);
  }

  String checkDdd(String ddd) {
    if (ddd.length == 1) {
      return 'Confira o formato.';
    }
    return '';
  }

  @action
  void setPhone1(String phone1) {
    phone1Error = checkPhone(phone1, _ddd1);
    _phone1 = phone1;
  }

  @action
  void setPhone2(String phone2) {
    phone2Error = checkPhone(phone2, _ddd2);
    _phone2 = phone2;
  }

  @action
  String checkPhone(String currentPhone, String ddd) {
    if (ddd.isNotEmpty){
      if(currentPhone.isEmpty) {
        return 'Telefone ?? um campo obrigat??rio';
      }
    } 
    if (currentPhone.isNotEmpty && currentPhone.length < 8) {
      return 'Confira o formato';
    }
    return '';
  }

  @action
  void setCep(String cep) {
    _cep = cep;
  }

  @action
  void setComplement(String complement) {
    _complement = complement;
  }

  @action
  void setNeighborhood(String neighborhood) {
    _neighborhood = neighborhood;
  }

  @action
  void setCity(String city) {
    cityError = city.isNotEmpty ? '' : 'Munic??pio ?? campo obrigat??rio';
    _city = city;
  }

  @action
  void setNumber(String number) {    
    numberError = number.isNotEmpty ? '' : 'N??mero ?? campo obrigat??rio';
    _number = number;
  }

  @action
  void setEmail(String email) {
    _email = email;
  }

  @action
  void setHour(String hour) {
    _hour = hour;
  }

  @action
  Future<void> savePlace() async {
    resetErrors();

    if (_category == null) {
      categoryError = 'Categoria ?? um campo obrigat??rio';
    }

    if (_coverage == null) {
      coverageError = 'Abrang??ncia ?? campo obrigat??rio';
    }

    if (_uf == null) {
      ufError = 'Estado ?? campo obrigat??rio';
    }

    if (_address == null || _address!.isEmpty) {
      addressError =
          'Nome do logradouro (Rua, Avenida, etc.) ?? campo obrigat??rio';
    }

    if (_placeName == null || _placeName!.isEmpty) {
      placeNameError = 'Nome do ponto de apoio ?? um campo obrigat??rio';
    }

    if (_number == null || _number!.isEmpty) {
      numberError = 'N??mero ?? campo obrigat??rio';
    }

    if (_city == null || _city!.isEmpty) {
      cityError = 'Munic??pio ?? campo obrigat??rio';
    }

    if (_ddd1.length == 1) {
      ddd1Error = 'Confira o formato.';
    }

    if (_ddd2.length == 1) {
      ddd2Error = 'Confira o formato.';
    }
    
    phone1Error = checkPhone(_phone1, _ddd1);

    phone2Error = checkPhone(_phone2, _ddd2);

    _savingSuggestion = ObservableFuture(
      _supportCenterUseCase.saveSuggestion(
        name: _placeName,
        address: _address,
        email: _email,
        category: _category!.id,
        coverage: _coverage,
        observation: _observation,
        cep: _cep,
        uf: _uf,
        number: _number,
        complement: _complement,
        neighborhood: _neighborhood,
        city: _city,
        hour: _hour,
        ddd1: _ddd1,
        phone1: _phone1,
        ddd2: _ddd2,
        phone2: _phone2,
        is24h: _is24h,
        hasWhatsapp: _hasWhatsapp,
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
    phone1Error = '';
    phone2Error = '';
    ddd1Error = '';
    ddd2Error = '';
    placeDescriptionError = '';
    categoryError = '';
    coverageError = '';
    emailError = '';
    cepError = '';
    ufError = '';
    cityError = '';
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
        title: field.title ?? 'Sugest??o enviada',
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
