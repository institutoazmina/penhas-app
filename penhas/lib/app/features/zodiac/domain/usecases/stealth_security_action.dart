import 'dart:async';

import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/security_mode_action_feature.dart';
import 'package:penhas/app/shared/logger/log.dart';

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

  StealthSecurityAction({
    required ILocationServices locationService,
    required IAudioRecordServices audioServices,
    required IGuardianRepository guardianRepository,
    required SecurityModeActionFeature featureToogle,
  })  : _audioServices = audioServices,
        _featureToogle = featureToogle,
        _locationService = locationService,
        _guardianRepository = guardianRepository;

  Stream<bool> get isRunning => _streamController!.stream;

  Future<void> start() async {
    _streamController ??= StreamController.broadcast();

    return _getCurrentLocatin()
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
      print(e);
    }
  }

  Future<UserLocationEntity> _getCurrentLocatin() async {
    return _locationService
        .currentLocation()
        .then((v) => v.getOrElse(() => const UserLocationEntity())!);
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

        if (_currentRecordDurantion >= _audioDurationEntity!.audioFullDuration) {
          timer.cancel();
          _streamController!.add(false);
          _recording = false;
        }

        _audioServices.rotate();
      },
    );
  }
}
