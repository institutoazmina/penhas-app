import 'dart:convert';

import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_record_duration_entity.dart';

class SecurityModeActionFeature {
  final IAppModulesServices _modulesServices;
  static String featureCode = 'modo_seguranca';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(
        name: SecurityModeActionFeature.featureCode);
    return module != null;
  }

  Future<String> get callingNumber => _callingNumber();
  Future<AudioRecordDurationEntity> get audioDuration => _audioDuration();

  SecurityModeActionFeature({@required IAppModulesServices modulesServices})
      : this._modulesServices = modulesServices;

  Future<String> _callingNumber() {
    return _modulesServices
        .feature(name: SecurityModeActionFeature.featureCode)
        .then((module) => jsonDecode(module.meta))
        .then((json) => json as Map<String, Object>)
        .then((json) => json['numero']);
  }

  Future<AudioRecordDurationEntity> _audioDuration() {
    return _modulesServices
        .feature(name: SecurityModeActionFeature.featureCode)
        .then((module) => jsonDecode(module.meta))
        .then((json) => json as Map<String, Object>)
        .then((json) => _mapAudioDuration(json));
  }

  AudioRecordDurationEntity _mapAudioDuration(Map<String, Object> json) {
    try {
      int audioEachDuration = int.parse(json['audio_each_duration'] as String);
      int audioFullDuration = int.parse(json['audio_full_duration'] as String);
      return AudioRecordDurationEntity(audioEachDuration, audioFullDuration);
    } catch (e) {
      return AudioRecordDurationEntity(30, 900);
    }
  }
}
