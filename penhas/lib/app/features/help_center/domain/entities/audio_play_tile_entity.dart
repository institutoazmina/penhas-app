import 'package:meta/meta.dart';

import 'audio_entity.dart';

class AudioPlayTileEntity {
  final AudioEntity audio;
  final String description;
  final void Function(AudioEntity audio) onPlayAudio;
  final void Function(AudioEntity audio) onActionSheet;

  AudioPlayTileEntity({
    @required this.audio,
    @required this.description,
    @required this.onPlayAudio,
    @required this.onActionSheet,
  });
}
