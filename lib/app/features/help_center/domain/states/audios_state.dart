import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/audio_play_tile_entity.dart';

part 'audios_state.freezed.dart';

@freezed
class AudiosState with _$AudiosState {
  const factory AudiosState.initial() = _Initial;
  const factory AudiosState.loaded(
      List<AudioPlayTileEntity> audios, String message) = _Loaded;
  const factory AudiosState.error(String message) = _ErrorDetails;
}
