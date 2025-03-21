import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/audio_entity.dart';

part 'audio_tile_action.freezed.dart';

@freezed
class AudioTileAction with _$AudioTileAction {
  const factory AudioTileAction.initial() = _Initial;
  const factory AudioTileAction.notice(String message) = _Notice;
  const factory AudioTileAction.actionSheet(AudioEntity audio) = _ActionSheet;
}
