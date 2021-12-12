import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/models/alert_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/help_center_state.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/features/help_center/presentation/widget/request_location_permission_content_widget.dart';

part 'help_center_controller.g.dart';

class HelpCenterController extends _HelpCenterControllerBase
    with _$HelpCenterController {
  HelpCenterController({
    required IGuardianRepository guardianRepository,
    required ILocationServices locationService,
    required IAppConfiguration appConfiguration,
    required SecurityModeActionFeature featureToogle,
    required IAudioRecordServices audioServices,
  }) : super(
          guardianRepository,
          locationService,
          appConfiguration,
          featureToogle,
          audioServices,
        );
}

abstract class _HelpCenterControllerBase with Store, MapFailureMessage {
  _HelpCenterControllerBase(
    this._guardianRepository,
    this._locationService,
    this._appConfiguration,
    this._featureToogle,
    this._audioServices,
  );

  final IGuardianRepository _guardianRepository;
  final ILocationServices _locationService;
  final IAppConfiguration _appConfiguration;
  final SecurityModeActionFeature _featureToogle;
  final IAudioRecordServices _audioServices;

  @observable
  ObservableFuture<Either<Failure, AlertModel>>? _alertProgress;

  @observable
  HelpCenterState alertState = const HelpCenterState.initial();

  @observable
  bool isLocationPermissionRequired = false;

  @observable
  String? errorMessage = '';

  @computed
  PageProgressState get loadState {
    if (_alertProgress == null ||
        _alertProgress!.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _alertProgress!.status == FutureStatus.pending
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
  void audios() {
    Modular.to.pushNamed('/mainboard/helpcenter/audios');
  }

  @action
  Future<void> triggerGuardian() async {
    _locationService
        .requestPermission(
      title: 'O guardião precisa da sua localização',
      description: RequestLocationPermissionContentWidget(),
    )
        .then((value) {
      errorMessage = '';
      _resetAlertState();
      _getCurrentLocatin()
          .then((location) => _triggerGuardian(location))
          .then((value) => alertState = value);
    });
  }

  @action
  Future<void> triggerCallPolice() async {
    errorMessage = '';
    _resetAlertState();
    _featureToogle.callingNumber
        .then((number) => alertState = HelpCenterState.callingPolice(number))
        .then((v) => _guardianRepository.callPolice());
  }

  @action
  Future<void> triggerAudioRecord() async {
    errorMessage = '';
    _resetAlertState();
    await _audioServices.requestPermission().then(
          (value) => {
            value.maybeWhen(
              granted: () => Modular.to
                  .pushNamed('/mainboard/helpcenter/audioRecord')
                  .then((value) {
                if (value as bool) {
                  _setErrorMessage("Gravação finalizada.");
                }
              }),
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
        .then((v) => v.getOrElse(() => UserLocationEntity())!);
  }

  Future<HelpCenterState> _triggerGuardian(UserLocationEntity location) async {
    _alertProgress = ObservableFuture(_guardianRepository.alert(location));
    final Either<Failure, AlertModel> result = await _alertProgress!;

    return result.fold(
      (failure) => _parseFailure(failure),
      (message) => HelpCenterState.guardianTriggered(
        GuardianAlertMessageAction(
          title: message.title ?? 'Alerta enviado!',
          message: message.message,
          onPressed: () {},
        ),
      ),
    );
  }

  HelpCenterState _parseFailure(Failure failure) {
    const state = HelpCenterState.initial();
    if (failure is GuardianAlertGpsFailure) {
      return state;
    }

    errorMessage = mapFailureMessage(failure);
    return state;
  }

  Future<bool> _hasActivedGuardian() {
    return _appConfiguration.appMode.then((mode) => mode.hasActivedGuardian);
  }

  void _setErrorMessage(String? message) => errorMessage = message;

  void _resetAlertState() => alertState = HelpCenterState.initial();
}
