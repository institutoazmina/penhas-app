// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';

void main() {
  late IAudioSyncManager audioSyncManager;
  late FlutterSoundPlayer flutterSoundPlayer;
  late AudioEntity audioReference;
  late File fileReference;

  setUp(() {
    audioReference = AudioEntity(
      audioDuration: '123456',
      canPlay: true,
      createdAt: DateTime(2023, 2, 3, 14, 44),
      id: '123',
      isRequestGranted: true,
      isRequested: true,
    );

    fileReference =
        File('test/app/core/managers/audio_play_services_test.dart');

    audioSyncManager = MockAudioSyncManager();
    flutterSoundPlayer = MockFlutterSoundPlayer();
  });

  group(AudioPlayServices, () {
    group('start', () {
      test('with empty cache got a Failure', () async {
        // arrange
        when((() => audioSyncManager.cache(audioReference)))
            .thenAnswer((_) async => left(TestFailure()));
        final audioPlayServices = AudioPlayServices(
          audioSyncManager: audioSyncManager,
          player: flutterSoundPlayer,
        );

        // act
        final result = await audioPlayServices.start(audioReference);

        // assert
        verifyNever(() => flutterSoundPlayer.startPlayer(
              fromURI: any(named: 'fromURI'),
              codec: Codec.aacADTS,
              whenFinished: any(named: 'whenFinished'),
            ));

        expect(result.fold((l) => l, (r) => r), isA<TestFailure>());
      });
    });
    test('play the audio file', () async {
      // arrange
      when((() => audioSyncManager.cache(audioReference)))
          .thenAnswer((_) async => right(fileReference));
      final audioPlayServices = AudioPlayServices(
        audioSyncManager: audioSyncManager,
        player: flutterSoundPlayer,
      );

      when(() => flutterSoundPlayer.openPlayer()).thenAnswer(
        (_) async => null,
      );

      when(() => flutterSoundPlayer
          .setSubscriptionDuration(Duration(milliseconds: 100))).thenAnswer(
        (_) => Future.value(),
      );

      when(() => flutterSoundPlayer.startPlayer(
            fromURI: any(named: 'fromURI'),
            codec: Codec.aacADTS,
            whenFinished: any(named: 'whenFinished'),
          )).thenAnswer((_) => Future.value());

      // act
      final result = await audioPlayServices.start(audioReference);

      // assert
      verify(() => audioSyncManager.cache(audioReference)).called(1);
      expect(result.fold((l) => l, (r) => r), audioReference);
    });

    group('codec detection (recorder may fall back to aacMP4)', () {
      late Directory tmpDir;

      setUp(() {
        tmpDir = Directory.systemTemp.createTempSync('audio_codec_test');
        when(() => flutterSoundPlayer.isStopped).thenReturn(true);
        when(() => flutterSoundPlayer.closePlayer())
            .thenAnswer((_) => Future.value());
        when(() => flutterSoundPlayer.openPlayer())
            .thenAnswer((_) async => null);
        when(() => flutterSoundPlayer.setSubscriptionDuration(
            Duration(milliseconds: 100))).thenAnswer((_) => Future.value());
      });

      tearDown(() => tmpDir.deleteSync(recursive: true));

      Future<void> playFile(File file, Codec expected) async {
        when(() => audioSyncManager.cache(audioReference))
            .thenAnswer((_) async => right(file));
        when(() => flutterSoundPlayer.startPlayer(
              fromURI: any(named: 'fromURI'),
              codec: expected,
              whenFinished: any(named: 'whenFinished'),
            )).thenAnswer((_) => Future.value());

        final audioPlayServices = AudioPlayServices(
          audioSyncManager: audioSyncManager,
          player: flutterSoundPlayer,
        );

        await audioPlayServices.start(audioReference);
        // start() fire-and-forgets _play() inside Either.fold, so let its async
        // chain (release -> open -> startPlayer) drain before verifying.
        await pumpEventQueue();

        verify(() => flutterSoundPlayer.startPlayer(
              fromURI: file.path,
              codec: expected,
              whenFinished: any(named: 'whenFinished'),
            )).called(1);
      }

      test('plays a real ADTS file (0xFFFx sync word) as aacADTS', () async {
        await playFile(File('test/assets/audio/silence.aac'), Codec.aacADTS);
      });

      test('plays an MP4 container (ftyp box) as aacMP4', () async {
        // The downloaded file is named `{id}.cached`, so the codec must come
        // from the header, not the extension. 'ftyp' sits at byte offset 4.
        final file = File('${tmpDir.path}/123.cached')
          ..writeAsBytesSync([
            0x00, 0x00, 0x00, 0x18, // box size
            0x66, 0x74, 0x79, 0x70, // 'ftyp'
            0x4D, 0x34, 0x41, 0x20, // 'M4A '
          ]);
        await playFile(file, Codec.aacMP4);
      });

      test('falls back to aacADTS for an inconclusive header', () async {
        final file = File('${tmpDir.path}/garbage.cached')
          ..writeAsBytesSync([0x01, 0x02, 0x03, 0x04, 0x05, 0x06]);
        await playFile(file, Codec.aacADTS);
      });
    });

    test('dispose release the audio session', () async {
      // arrange
      when((() => audioSyncManager.cache(audioReference)))
          .thenAnswer((_) async => right(fileReference));
      final audioPlayServices = AudioPlayServices(
        audioSyncManager: audioSyncManager,
        player: flutterSoundPlayer,
      );

      when(() => flutterSoundPlayer.isStopped).thenReturn(false);
      when(() => flutterSoundPlayer.stopPlayer())
          .thenAnswer((_) => Future.value());
      when(() => flutterSoundPlayer.closePlayer())
          .thenAnswer((_) => Future.value());

      // act
      await audioPlayServices.dispose();

      // assert
      verify(() => flutterSoundPlayer.isStopped).called(1);
      verify(() => flutterSoundPlayer.stopPlayer()).called(1);
      verify(() => flutterSoundPlayer.closePlayer()).called(1);
    });
  });
}

class MockAudioSyncManager extends Mock implements IAudioSyncManager {}

class MockFlutterSoundPlayer extends Mock implements FlutterSoundPlayer {}

class TestFailure extends Failure {}
