import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

part 'audios_state.freezed.dart';

@freezed
abstract class AudiosState with _$AudiosState {
  const factory AudiosState.initial() = _Initial;
  const factory AudiosState.loaded(List<AudioEntity> audios) = _Loaded;
  const factory AudiosState.error(String message) = _ErrorDetails;
}
