import 'dart:convert';

import '../../../../core/managers/modules_sevices.dart';
import '../../../../shared/logger/log.dart';
import '../entities/audio_record_duration_entity.dart';

class SecurityModeActionFeature {
  SecurityModeActionFeature({required IAppModulesServices modulesServices})
      : _modulesServices = modulesServices;

  final IAppModulesServices _modulesServices;
  static String featureCode = 'modo_seguranca';

  Future<bool> get isEnabled => _isEnabled();

  Future<bool> _isEnabled() async {
    final module = await _modulesServices.feature(
      name: SecurityModeActionFeature.featureCode,
    );
    return module != null;
  }

  Future<String> get callingNumber => _callingNumber();
  Future<AudioRecordDurationEntity> get audioDuration => _audioDuration();

  Future<String> _callingNumber() {
    return _modulesServices
        .feature(name: SecurityModeActionFeature.featureCode)
        .then(
          (module) => jsonDecode(module?.meta ?? '{}') as Map<String, dynamic>,
        )
        .then((json) => json['numero'] as String);
  }

  Future<AudioRecordDurationEntity> _audioDuration() {
    return _modulesServices
        .feature(name: SecurityModeActionFeature.featureCode)
        .then((module) => jsonDecode(module?.meta ?? '{}'))
        .then((json) => _mapAudioDuration(json));
  }

  AudioRecordDurationEntity _mapAudioDuration(Map<String, dynamic> json) {
    try {
      final int audioEachDuration =
          int.parse(json['audio_each_duration'] as String);
      final int audioFullDuration =
          int.parse(json['audio_full_duration'] as String);
      return AudioRecordDurationEntity(audioEachDuration, audioFullDuration);
    } catch (e, stack) {
      logError(e, stack);
      return const AudioRecordDurationEntity(30, 900);
    }
  }
}
