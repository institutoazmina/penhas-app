import 'audio_entity.dart';

class AudioPlayTileEntity {
  AudioPlayTileEntity({
    required this.audio,
    required this.description,
    required this.onPlayAudio,
    required this.onActionSheet,
  });

  final AudioEntity audio;
  final String description;
  final void Function(AudioEntity audio) onPlayAudio;
  final void Function(AudioEntity audio) onActionSheet;
}
