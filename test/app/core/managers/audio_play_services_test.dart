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
        (_) async => null,
      );

      when(() => flutterSoundPlayer.startPlayer(
            fromURI: any(named: 'fromURI'),
            codec: Codec.aacADTS,
            whenFinished: any(named: 'whenFinished'),
          )).thenAnswer((_) async => null);

      // act
      final result = await audioPlayServices.start(audioReference);

      // assert
      verify(() => audioSyncManager.cache(audioReference)).called(1);
      expect(result.fold((l) => l, (r) => r), audioReference);
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
      when(() => flutterSoundPlayer.stopPlayer()).thenAnswer((_) async => null);
      when(() => flutterSoundPlayer.closePlayer())
          .thenAnswer((_) async => null);

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
