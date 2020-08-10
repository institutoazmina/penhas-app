import 'dart:convert';

import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_duration_entity.dart';

class HelpCenterCallActionFeature {
  final IAppModulesServices _modulesServices;
  final String _featureCode = 'modo_seguranca';

  Future<String> get callingNumber => _callingNumber();
  Future<AudioDurationEntity> get audioDuration => _audioDuration();

  HelpCenterCallActionFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<String> _callingNumber() {
    return _modulesServices
        .feature(name: _featureCode)
        .then((module) => jsonDecode(module.meta))
        .then((json) => json as Map<String, Object>)
        .then((json) => json['numero']);
  }

  Future<AudioDurationEntity> _audioDuration() {
    return _modulesServices
        .feature(name: _featureCode)
        .then((module) => jsonDecode(module.meta))
        .then((json) => json as Map<String, Object>)
        .then((json) => _mapAudioDuration(json));
  }

  AudioDurationEntity _mapAudioDuration(Map<String, Object> json) {
    try {
      int audioEachDuration = int.parse(json['audio_each_duration'] as String);
      int audioFullDuration = int.parse(json['audio_full_duration'] as String);
      return AudioDurationEntity(audioEachDuration, audioFullDuration);
    } catch (e) {
      return AudioDurationEntity(30, 900);
    }
  }
}
