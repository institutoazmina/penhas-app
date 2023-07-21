import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/audio_entity.dart';

part 'audio_playing.freezed.dart';

@freezed
class AudioPlaying with _$AudioPlaying {
  const factory AudioPlaying.none() = _None;
  const factory AudioPlaying.playing(AudioEntity audio) = _Playing;
}
