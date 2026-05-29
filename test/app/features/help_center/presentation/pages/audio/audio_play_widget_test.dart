import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/presentation/pages/audio/audio_play_widget.dart';

void main() {
  AudioEntity audio() => AudioEntity(
        id: 'event.aac',
        audioDuration: '1m30s',
        createdAt: DateTime(2023, 2, 3, 14, 44),
        canPlay: false,
        isRequested: false,
        isRequestGranted: false,
      );

  Future<void> pump(WidgetTester tester, AudioPlayTileEntity tile) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AudioPlayWidget(
            audioPlay: tile,
            isPlaying: false,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  group(AudioPlayWidget, () {
    testWidgets('uploading tile shows spinner, progress bar and no controls',
        (tester) async {
      final tile = AudioPlayTileEntity(
        audio: audio(),
        description: 'Enviando áudio... 42%',
        onPlayAudio: (_) {},
        onActionSheet: (_) {},
        uploadStatus: TileUploadStatus.uploading,
        uploadProgress: 42,
      );

      await pump(tester, tile);

      expect(find.text('Enviando áudio... 42%'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      final bar = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(bar.value, closeTo(0.42, 0.0001));

      // a pending tile is not playable and exposes no action menu
      expect(find.byIcon(Icons.play_circle_filled), findsNothing);
      expect(find.byIcon(Icons.save_alt), findsNothing);
      expect(find.byIcon(Icons.more_vert), findsNothing);
    });

    testWidgets('waitingNetwork tile shows cloud_off and no progress bar',
        (tester) async {
      final tile = AudioPlayTileEntity(
        audio: audio(),
        description: 'Aguardando rede para enviar',
        onPlayAudio: (_) {},
        onActionSheet: (_) {},
        uploadStatus: TileUploadStatus.waitingNetwork,
      );

      await pump(tester, tile);

      expect(find.text('Aguardando rede para enviar'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.more_vert), findsNothing);
    });

    testWidgets('confirmed tile shows the action menu and no upload indicators',
        (tester) async {
      final tile = AudioPlayTileEntity(
        audio: audio(),
        description: 'Toque no ícone para solicitar o audio',
        onPlayAudio: (_) {},
        onActionSheet: (_) {},
      );

      await pump(tester, tile);

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.cloud_off), findsNothing);
    });
  });
}
