import 'audio_entity.dart';
import 'package:meta/meta.dart';

class AudioPlayTileEntity {
  final AudioEntity audio;
  final String description;
  final void Function(AudioEntity audio) playAudio;
  final void Function(AudioEntity audio) action;

  AudioPlayTileEntity({
    @required this.audio,
    @required this.description,
    @required this.playAudio,
    @required this.action,
  });
}
