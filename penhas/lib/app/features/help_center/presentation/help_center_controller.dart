import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/audio_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/help_center_state.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';

part 'help_center_controller.g.dart';

class HelpCenterController extends _HelpCenterControllerBase
    with _$HelpCenterController {
  HelpCenterController({
    @required IGuardianRepository guardianRepository,
    @required ILocationServices locationService,
    @required IAppConfiguration appConfiguration,
    @required HelpCenterCallActionFeature featureToogle,
    @required IAudioServices audioServices,
  }) : super(
          guardianRepository,
          locationService,
          appConfiguration,
          featureToogle,
          audioServices,
        );
}

abstract class _HelpCenterControllerBase with Store, MapFailureMessage {
  final IGuardianRepository _guardianRepository;
  final ILocationServices _locationService;
  final IAppConfiguration _appConfiguration;
  final HelpCenterCallActionFeature _featureToogle;
  final IAudioServices _audioServices;

  _HelpCenterControllerBase(
    this._guardianRepository,
    this._locationService,
    this._appConfiguration,
    this._featureToogle,
    this._audioServices,
  );

  @observable
  ObservableFuture<Either<Failure, ValidField>> _alertProgress;

  @observable
  HelpCenterState alertState = HelpCenterState.initial();

  @observable
  bool isLocationPermissionRequired = false;

  @observable
  String errorMessage = '';

  @computed
  PageProgressState get loadState {
    if (_alertProgress == null ||
        _alertProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _alertProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  void newGuardian() {
    Modular.to
        .pushNamed('/mainboard/helpcenter/newGuardian')
        .then((value) => checkLocalicationRequired());
  }

  @action
  void guardians() {
    Modular.to
        .pushNamed('/mainboard/helpcenter/guardians')
        .then((value) => checkLocalicationRequired());
  }

  @action
  Future<void> triggerGuardian() async {
    _setErrorMessage('');
    _resetAlertState();
    _getCurrentLocatin()
        .then((location) => _triggerGuardian(location))
        .then((value) => alertState = value);
  }

  @action
  Future<void> triggerCallPolice() async {
    _setErrorMessage('');
    _resetAlertState();
    _featureToogle.callingNumber
        .then((number) => alertState = HelpCenterState.callingPolice(number));
  }

  @action
  Future<void> triggerAudioRecord() async {
    _setErrorMessage('');
    _resetAlertState();
    await _audioServices.requestPermission().then(
          (value) => {
            value.maybeWhen(
              granted: () =>
                  Modular.to.pushNamed('/mainboard/helpcenter/audioRecord'),
              orElse: () {},
            )
          },
        );
  }

  @action
  Future<void> checkLocalicationRequired() async {
    _locationService
        .permissionStatus()
        .then(
          (value) => value.maybeWhen(
            granted: () => false,
            orElse: () async => _hasActivedGuardian(),
          ),
        )
        .then((value) => value as bool)
        .then((value) => isLocationPermissionRequired = value);
  }

  Future<UserLocationEntity> _getCurrentLocatin() async {
    return _locationService
        .currentLocation()
        .then((v) => v.getOrElse(() => UserLocationEntity()));
  }

  Future<HelpCenterState> _triggerGuardian(UserLocationEntity location) async {
    _alertProgress = ObservableFuture(_guardianRepository.alert(location));
    final result = await _alertProgress;

    return result.fold(
      (failure) => _parseFailure(failure),
      (message) => HelpCenterState.guardianTriggered(
        GuardianAlertMessageAction(message: message.message, onPressed: () {}),
      ),
    );
  }

  HelpCenterState _parseFailure(Failure failure) {
    final state = HelpCenterState.initial();
    if (failure is GuardianAlertGpsFailure) {
      return state;
    }

    _setErrorMessage(mapFailureMessage(failure));
    return state;
  }

  Future<bool> _hasActivedGuardian() {
    return _appConfiguration.appMode.then((mode) => mode.hasActivedGuardian);
  }

  void _setErrorMessage(String message) => errorMessage = message;

  void _resetAlertState() => alertState = HelpCenterState.initial();
}
