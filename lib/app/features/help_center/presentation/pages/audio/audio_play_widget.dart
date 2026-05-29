import 'package:flutter/material.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../domain/entities/audio_play_tile_entity.dart';

class AudioPlayWidget extends StatelessWidget {
  const AudioPlayWidget({
    super.key,
    required this.audioPlay,
    required this.isPlaying,
    required this.backgroundColor,
  });

  final AudioPlayTileEntity audioPlay;
  final bool isPlaying;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey[350]!),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (audioPlay.uploadStatus != null)
                    _buildUploadIndicator()
                  else ...[
                    IconButton(
                      // Accessibility label so the icon-only control is
                      // reachable by name (tests / screen readers).
                      tooltip: audioPlay.audio.canPlay
                          ? 'Ouvir áudio'
                          : 'Solicitar áudio',
                      icon: _buildPlayIcone,
                      color: isPlaying
                          ? DesignSystemColors.ligthPurple
                          : DesignSystemColors.charcoalGrey2,
                      onPressed: () =>
                          audioPlay.onPlayAudio(audioPlay.audio),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        audioPlay.audio.audioDuration ?? '',
                        style: kTextStyleAudioDuration,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audioPlay.description,
                    style: kTextStyleAudioDescription,
                  ),
                  if (audioPlay.uploadStatus == TileUploadStatus.uploading &&
                      audioPlay.uploadProgress != null) ...[
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: audioPlay.uploadProgress! / 100,
                      backgroundColor: Colors.grey[300],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (audioPlay.uploadStatus == null)
            Expanded(
              child: SizedBox(
                height: 44,
                width: 44,
                child: IconButton(
                  tooltip: 'Mais opções',
                  icon: const Icon(Icons.more_vert),
                  onPressed: () =>
                      audioPlay.onActionSheet(audioPlay.audio),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildUploadIndicator() {
    switch (audioPlay.uploadStatus) {
      case TileUploadStatus.uploading:
        return const SizedBox(
          height: 36,
          width: 36,
          child: CircularProgressIndicator(strokeWidth: 3),
        );
      case TileUploadStatus.waitingNetwork:
        return const Icon(Icons.cloud_off, size: 28, color: Colors.grey);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget get _buildPlayIcone {
    return audioPlay.audio.canPlay
        ? const Icon(Icons.play_circle_filled, size: 36)
        : const Icon(Icons.save_alt, size: 26);
  }
}
