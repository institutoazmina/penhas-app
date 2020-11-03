import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/cep.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_location_state.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

part 'support_center_location_controller.g.dart';

class SupportCenterLocationController
    extends _SupportCenterLocationControllerBase
    with _$SupportCenterLocationController {
  SupportCenterLocationController({
    @required SupportCenterUseCase supportCenterUseCase,
  }) : super(supportCenterUseCase);
}

abstract class _SupportCenterLocationControllerBase
    with Store, MapFailureMessage {
  final SupportCenterUseCase _supportCenterUseCase;
  GeolocationEntity _selectedGeoLocation;

  _SupportCenterLocationControllerBase(this._supportCenterUseCase);

  @observable
  ObservableFuture<Either<Failure, GeolocationEntity>> _getGeoToken;

  @observable
  SupportCenterLocationState state = SupportCenterLocationState.initial();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_getGeoToken);
  }

  @action
  void setCep(String cep) {
    Cep currentCep = Cep(cep);

    if (currentCep.isValid) {
      getGeoToken(currentCep);
    }
  }

  @action
  Future<void> seletedAddress() async {
    Modular.to.pop(
      _supportCenterUseCase.updatedGeoLocation(_selectedGeoLocation),
    );
  }

  @action
  Future<void> askForLocationPermission() async {
    final permission = await _supportCenterUseCase.askForLocationPermission(
      "Localização",
      Text(
        "Permintindo que a PenhaS tenha acesso a tua localização, será possivel apresentar os pontos de apoio mais próximo da onde você está.",
        style: TextStyle(
          color: DesignSystemColors.darkIndigoThree,
          fontFamily: 'Lato',
          fontSize: 14.0,
          letterSpacing: 0.45,
          fontWeight: FontWeight.normal,
        ),
      ),
    );

    Modular.to.pop(permission);
  }
}

extension _PrivateMethods on _SupportCenterLocationControllerBase {
  Future<void> getGeoToken(Cep cep) async {
    _getGeoToken = ObservableFuture(_supportCenterUseCase.mapGeoFromCep(cep));

    final result = await _getGeoToken;

    result.fold(
      (failure) => handleFailure(failure),
      (geoLocation) => handleSuccessGeoToken(geoLocation),
    );
  }

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  void handleFailure(Failure failure) {
    if (failure is AddressFailure) {
      state = SupportCenterLocationState.addressNotFound(failure.message);
      return;
    }

    state = SupportCenterLocationState.error(mapFailureMessage(failure));
  }

  void handleSuccessGeoToken(GeolocationEntity geolocation) {
    _selectedGeoLocation = geolocation;
    state = SupportCenterLocationState.loaded(_selectedGeoLocation.label);
  }
}
