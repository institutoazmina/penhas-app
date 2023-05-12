import 'dart:async';
import '../../../../core/entities/user_location.dart';
import '../../../../core/managers/audio_record_services.dart';
import '../../../../core/managers/location_services.dart';
import '../../../help_center/data/repositories/guardian_repository.dart';
import '../../../help_center/domain/entities/audio_record_duration_entity.dart';
import '../../../help_center/domain/usecases/security_mode_action_feature.dart';
import '../../../../shared/logger/log.dart';
import '../../presentation/widgets/request_location_permission_content_widget.dart';


class StealthSecurityAction {
  StealthSecurityAction({
    required ILocationServices locationService,
    required IAudioRecordServices audioServices,
    required IGuardianRepository guardianRepository,
    required SecurityModeActionFeature featureToogle,
  })  : _audioServices = audioServices,
        _featureToogle = featureToogle,
        _locationService = locationService,
        _guardianRepository = guardianRepository;

  final ILocationServices _locationService;
  final IAudioRecordServices _audioServices;
  final IGuardianRepository _guardianRepository;
  final SecurityModeActionFeature _featureToogle;

  bool _recording = true;
  Timer? _rotateAudioTimer;
  int _currentRecordDurantion = 0;
  AudioRecordDurationEntity? _audioDurationEntity;
  StreamController<bool>? _streamController = StreamController.broadcast();

  Stream<bool> get isRunning => _streamController!.stream;

  Future<void> start() async {
    _streamController ??= StreamController.broadcast();

    return _getCurrentLocation()
        .then((location) => _triggerGuardian(location))
        .then((_) => _startAudioRecord())
        .then((_) => _streamController!.add(true));
  }

  Future<void> stop() async {
    _recording = false;
    _rotateAudioTimer?.cancel();
    _audioServices.stop();
    _streamController!.add(false);
  }

  Future<void> dispose() async {
    await stop();
    _audioServices.dispose();

    try {
      if (_streamController != null) {
        _streamController!.close();
        _streamController = null;
      }
    } catch (e, stack) {
      logError(e, stack);
    }
  }

  Future<UserLocationEntity> _getCurrentLocation() async {
    await _locationService.requestPermission(
      title: 'O guardião precisa da sua localização',
      description: RequestLocationPermissionContentWidget(),
    );

    final hasPermission = await hasLocationPermission();

    if (hasPermission) {
      return _locationService.currentLocation().then((v) {
        return v.getOrElse(() => const UserLocationEntity())!;
      });
    }

    return const UserLocationEntity();
  }

  Future<void> _triggerGuardian(UserLocationEntity location) async {
    await _guardianRepository.alert(location);
  }

  Future<void> _startAudioRecord() async {
    _audioDurationEntity ??= await _featureToogle.audioDuration;

    _setRotateTimer();
    return _audioServices.start();
  }

  void _setRotateTimer() {
    _rotateAudioTimer = Timer.periodic(
      Duration(seconds: _audioDurationEntity!.audioEachDuration),
      (timer) {
        if (!_recording) {
          timer.cancel();
          _streamController!.add(false);
          return;
        }

        _currentRecordDurantion += _audioDurationEntity!.audioEachDuration;

        if (_currentRecordDurantion >=
            _audioDurationEntity!.audioFullDuration) {
          timer.cancel();
          _streamController!.add(false);
          _recording = false;
        }

        _audioServices.rotate();
      },
    );
  }
}

extension _PrivateMethods on StealthSecurityAction {
  Future<bool> hasLocationPermission() {
    return _locationService.isPermissionGranted();
  }
}
