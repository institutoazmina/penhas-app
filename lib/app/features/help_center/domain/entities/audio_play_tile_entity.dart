import 'audio_entity.dart';

enum TileUploadStatus { uploading, waitingNetwork }

class AudioPlayTileEntity {
  AudioPlayTileEntity({
    required this.audio,
    required this.description,
    required this.onPlayAudio,
    required this.onActionSheet,
    this.uploadStatus,
    this.uploadProgress,
  });

  final AudioEntity audio;
  final String description;
  final void Function(AudioEntity audio) onPlayAudio;
  final void Function(AudioEntity audio) onActionSheet;
  final TileUploadStatus? uploadStatus;
  final double? uploadProgress;
}
