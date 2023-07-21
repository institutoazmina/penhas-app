import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/managers/audio_record_services.dart';
import '../../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../domain/entities/audio_record_duration_entity.dart';
import '../../../domain/usecases/security_mode_action_feature.dart';

part 'audio_record_controller.g.dart';

class AudioRecordController extends _AudioRecordController
    with _$AudioRecordController {
  AudioRecordController({
    required IAudioRecordServices audioServices,
    required SecurityModeActionFeature featureToogle,
  }) : super(audioServices, featureToogle);
}

abstract class _AudioRecordController with Store, MapFailureMessage {
  _AudioRecordController(this._audioServices, this._featureToogle);

  final IAudioRecordServices _audioServices;
  final SecurityModeActionFeature _featureToogle;

  bool _recording = true;
  Timer? _rotateAudioTimer;
  int _currentRecordDurantion = 0;
  AudioRecordDurationEntity? _audioDurationEntity;

  @action
  Future<void> startAudioRecord() async {
    _audioDurationEntity ??= await _featureToogle.audioDuration;

    _setRotateTimer();
    return _audioServices.start();
  }

  @action
  Future<void> stopAudioRecord() async {
    await dispose();
    Modular.to.pop(true);
  }

  Stream<AudioActivity> get audioActivity => _audioServices.onProgress;

  Future<void> dispose() async {
    _recording = false;
    _rotateAudioTimer?.cancel();
    await _audioServices.stop();
    _audioServices.dispose();
  }

  void _setRotateTimer() {
    _rotateAudioTimer = Timer.periodic(
        Duration(seconds: _audioDurationEntity!.audioEachDuration), (timer) {
      if (!_recording) {
        timer.cancel();
        return;
      }

      _currentRecordDurantion += _audioDurationEntity!.audioEachDuration;

      if (_currentRecordDurantion >= _audioDurationEntity!.audioFullDuration) {
        timer.cancel();
        Modular.to.pop();
      }

      _audioServices.rotate();
    });
  }
}
