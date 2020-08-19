import 'package:meta/meta.dart';

import 'audio_entity.dart';

class AudioTileActionSheetEntity {
  final AudioEntity audio;
  final void Function(AudioEntity audio) onDelete;

  AudioTileActionSheetEntity({@required this.audio, @required this.onDelete});
}
