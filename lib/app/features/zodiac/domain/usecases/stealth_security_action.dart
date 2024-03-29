import 'dart:async';

import '../../../../core/entities/user_location.dart';
import '../../../../core/managers/audio_record_services.dart';
import '../../../../core/managers/location_services.dart';
import '../../../../shared/logger/log.dart';
import '../../../../shared/widgets/request_location_permission_content_widget.dart';
import '../../../help_center/data/repositories/guardian_repository.dart';
import '../../../help_center/domain/entities/audio_record_duration_entity.dart';
import '../../../help_center/domain/usecases/security_mode_action_feature.dart';

class StealthSecurityAction {
  StealthSecurityAction({
    required ILocationServices locationService,
    required IAudioRecordServices audioServices,
    required IGuardianRepository guardianRepository,
    required SecurityModeActionFeature featureToggle,
  })  : _audioServices = audioServices,
        _featureToggle = featureToggle,
        _locationService = locationService,
        _guardianRepository = guardianRepository;

  final ILocationServices _locationService;
  final IAudioRecordServices _audioServices;
  final IGuardianRepository _guardianRepository;
  final SecurityModeActionFeature _featureToggle;

  bool _recording = true;
  Timer? _rotateAudioTimer;
  int _currentRecordDuration = 0;
  AudioRecordDurationEntity? _audioDurationEntity;
  StreamController<bool>? _streamController = StreamController.broadcast();

  Stream<bool> get isRunning => _streamController!.stream;

  Future<void> start() async {
    _streamController ??= StreamController.broadcast();

    return await _getCurrentLocation()
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
    final hasPermission = await _hasLocationPermission();

    if (hasPermission) {
      return _parseCurrentLocation();
    }

    return const UserLocationEntity();
  }

  Future<UserLocationEntity> _parseCurrentLocation() async {
    final location = await _locationService.currentLocation();

    return location.fold((l) {
      logError(l);
      return const UserLocationEntity();
    }, (r) => _formatCoordinates(r));
  }

  Future<void> _triggerGuardian(UserLocationEntity location) async {
    await _guardianRepository.alert(location);
  }

  Future<void> _startAudioRecord() async {
    _audioDurationEntity ??= await _featureToggle.audioDuration;

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

        _currentRecordDuration += _audioDurationEntity!.audioEachDuration;

        if (_currentRecordDuration >= _audioDurationEntity!.audioFullDuration) {
          timer.cancel();
          _streamController!.add(false);
          _recording = false;
        }

        _audioServices.rotate();
      },
    );
  }

  Future<bool> _hasLocationPermission() async {
    await _locationService.requestPermission(
      title: 'O guardião precisa da sua localização',
      description: const RequestLocationPermissionContentWidget(),
    );

    return _locationService.isPermissionGranted();
  }

  UserLocationEntity _formatCoordinates(UserLocationEntity? location) {
    if (location != null) {
      return UserLocationEntity(
          accuracy: location.accuracy,
          latitude: double.parse(location.latitude.toStringAsFixed(7)),
          longitude: double.parse(location.longitude.toStringAsFixed(7)));
    }
    return const UserLocationEntity();
  }
}
