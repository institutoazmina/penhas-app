import 'dart:async';

import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';

class StealthSecurityAction {
  final ILocationServices _locationService;
  final IAudioRecordServices _audioServices;
  final IGuardianRepository _guardianRepository;
  final HelpCenterCallActionFeature _featureToogle;

  bool _recording = true;
  Timer _rotateAudioTimer;
  int _currentRecordDurantion = 0;
  AudioRecordDurationEntity _audioDurationEntity;
  StreamController<bool> _streamController = StreamController.broadcast();

  StealthSecurityAction({
    @required ILocationServices locationService,
    @required IAudioRecordServices audioServices,
    @required IGuardianRepository guardianRepository,
    @required HelpCenterCallActionFeature featureToogle,
  })  : this._audioServices = audioServices,
        this._featureToogle = featureToogle,
        this._locationService = locationService,
        this._guardianRepository = guardianRepository;

  Stream<bool> get isRunning => _streamController.stream;

  Future<void> start() async {
    return _getCurrentLocatin()
        .then((location) => _triggerGuardian(location))
        .then((_) => _startAudioRecord())
        .then((_) => _streamController.add(true));
  }

  Future<void> stop() async {
    _recording = false;
    _rotateAudioTimer?.cancel();
    _audioServices.stop();
    _audioServices.dispose();
    _streamController.add(false);
  }

  void dispose() async {
    await stop();

    try {
      if (_streamController != null) {
        _streamController.close();
        _streamController = null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserLocationEntity> _getCurrentLocatin() async {
    return _locationService
        .currentLocation()
        .then((v) => v.getOrElse(() => UserLocationEntity()));
  }

  Future<void> _triggerGuardian(UserLocationEntity location) async {
    final foo = await _guardianRepository.alert(location);
    print(foo);
    return;
  }

  Future<void> _startAudioRecord() async {
    if (_audioDurationEntity == null) {
      _audioDurationEntity = await _featureToogle.audioDuration;
    }

    _setRotateTimer();
    return _audioServices.start();
  }

  void _setRotateTimer() {
    _rotateAudioTimer = Timer.periodic(
      Duration(seconds: _audioDurationEntity.audioEachDuration),
      (timer) {
        if (!_recording) {
          timer.cancel();
          _streamController.add(false);
          return;
        }

        _currentRecordDurantion += _audioDurationEntity.audioEachDuration;

        if (_currentRecordDurantion >= _audioDurationEntity.audioFullDuration) {
          timer.cancel();
          _streamController.add(false);
          _recording = false;
        }

        _audioServices.rotate();
      },
    );
  }
}
