import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';
import 'package:penhas/app/features/help_center/domain/usecases/help_center_call_action_feature.dart';

part 'audio_record_controller.g.dart';

class AudioRecordController extends _AudioRecordController
    with _$AudioRecordController {
  AudioRecordController({
    @required IAudioRecordServices audioServices,
    @required HelpCenterCallActionFeature featureToogle,
  }) : super(audioServices, featureToogle);
}

abstract class _AudioRecordController with Store, MapFailureMessage {
  final IAudioRecordServices _audioServices;
  final HelpCenterCallActionFeature _featureToogle;

  bool _recording = true;
  Timer _rotateAudioTimer;
  int _currentRecordDurantion = 0;
  AudioRecordDurationEntity _audioDurationEntity;

  _AudioRecordController(this._audioServices, this._featureToogle);

  @action
  Future<void> startAudioRecord() async {
    if (_audioDurationEntity == null) {
      _audioDurationEntity = await _featureToogle.audioDuration;
    }

    _setRotateTimer();
    return _audioServices.start();
  }

  @action
  Future<void> stopAudioRecord() async {
    dispose();
    Modular.to.pop();
  }

  Stream<AudioActivity> get audioActivity => _audioServices.onProgress;

  void dispose() {
    _recording = false;
    _rotateAudioTimer?.cancel();
    _audioServices.stop();
    _audioServices.dispose();
  }

  void _setRotateTimer() {
    _rotateAudioTimer = Timer.periodic(
        Duration(seconds: _audioDurationEntity.audioEachDuration), (timer) {
      if (!_recording) {
        timer.cancel();
        return;
      }

      _currentRecordDurantion += _audioDurationEntity.audioEachDuration;

      if (_currentRecordDurantion >= _audioDurationEntity.audioFullDuration) {
        timer.cancel();
        Modular.to.pop();
      }

      _audioServices.rotate();
    });
  }
}
