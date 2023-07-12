import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/entities/user_location.dart';
import '../../../core/error/failures.dart';
import '../../../core/managers/app_configuration.dart';
import '../../../core/managers/audio_record_services.dart';
import '../../../core/managers/location_services.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../data/models/alert_model.dart';
import '../data/repositories/guardian_repository.dart';
import '../domain/states/guardian_alert_state.dart';
import '../domain/states/help_center_state.dart';
import '../domain/usecases/security_mode_action_feature.dart';

import '../../../shared/widgets/request_location_permission_content_widget.dart';

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
      description: const RequestLocationPermissionContentWidget(),
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
                if (value == true) {
                  errorMessage = 'Gravação finalizada.';
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
        .then((v) => v.getOrElse(() => const UserLocationEntity())!);
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

  void _resetAlertState() => alertState = const HelpCenterState.initial();
}
