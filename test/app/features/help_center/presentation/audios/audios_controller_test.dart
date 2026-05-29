import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/audio_play_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/features/help_center/data/models/audio_model.dart';
import 'package:penhas/app/features/help_center/data/repositories/audios_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/audio_play_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/audios_state.dart';
import 'package:penhas/app/features/help_center/presentation/audios/audios_controller.dart';

import '../../../../../utils/json_util.dart';

class MockAudiosRepository extends Mock implements IAudiosRepository {}

class MockAudioPlayServices extends Mock implements IAudioPlayServices {}

class MockAudioSyncManager extends Mock implements IAudioSyncManager {}

class AudioEntityFake extends Fake implements AudioEntity {}

void main() {
  late MockAudiosRepository audiosRepository;
  late MockAudioPlayServices audioPlayServices;
  late MockAudioSyncManager audioSyncManager;
  late AudioEntity audioReference;

  late AudiosController sut;
  late Map<String, dynamic> jsonData;

  // Pulls the tile list out of the freezed [AudiosState] union (or fails).
  List<AudioPlayTileEntity> loadedTiles(AudiosState state) => state.when(
        initial: () => fail('expected loaded state, got initial'),
        loaded: (audios, _) => audios,
        error: (message) => fail('expected loaded state, got error: $message'),
      );

  setUpAll(() {
    registerFallbackValue(AudioEntityFake());
  });

  group(AudiosController, () {
    setUp(() async {
      audioPlayServices = MockAudioPlayServices();
      audiosRepository = MockAudiosRepository();
      audioSyncManager = MockAudioSyncManager();

      jsonData = await JsonUtil.getJson(from: 'audios/audios_fetch.json');

      audioReference = AudioEntity(
        audioDuration: '123456',
        canPlay: true,
        createdAt: DateTime(2023, 2, 3, 14, 44),
        id: '123',
        isRequestGranted: true,
        isRequested: true,
      );

      // No pending uploads unless a test overrides it.
      when(() => audioSyncManager.pendingUploads())
          .thenAnswer((_) async => <Map<String, String>>[]);
      when(() => audiosRepository.fetch())
          .thenAnswer((_) async => right(AudioModel.fromJson(jsonData)));

      sut = AudiosController(
        audioPlayServices: audioPlayServices,
        audiosRepository: audiosRepository,
        audioSyncManager: audioSyncManager,
      );
    });

    test('delete removes the audio and reloads the list', () async {
      // arrange
      when(() => audiosRepository.delete(any()))
          .thenAnswer((_) async => right(const ValidField(message: '')));

      // act
      await sut.delete(audioReference);

      // assert
      verify(() => audiosRepository.delete(audioReference)).called(1);
      verify(() => audiosRepository.fetch()).called(1);
    });

    group('loadPage', () {
      test('emits server audios when there are no pending uploads', () async {
        // act
        await sut.loadPage();

        // assert
        final tiles = loadedTiles(sut.currentState);
        // fixture has 2 audios, no pending uploads were stubbed
        expect(tiles, hasLength(2));
        expect(tiles.every((t) => t.uploadStatus == null), isTrue);
      });

      test('emits an error state when the fetch fails', () async {
        // arrange
        when(() => audiosRepository.fetch())
            .thenAnswer((_) async => left(ServerFailure()));

        // act
        await sut.loadPage();

        // assert
        final isError = sut.currentState.when(
          initial: () => false,
          loaded: (_, __) => false,
          error: (_) => true,
        );
        expect(isError, isTrue);
      });

      test(
        'prepends optimistic tiles for pending uploads before server audios',
        () async {
          // arrange
          when(() => audioSyncManager.pendingUploads()).thenAnswer(
            (_) async => [
              {'taskId': 'running.aac', 'status': 'running', 'progress': '42'},
              {
                'taskId': 'waiting.aac',
                'status': 'enqueued',
                'progress': '0',
              },
            ],
          );

          // act
          await sut.loadPage();

          // assert
          final tiles = loadedTiles(sut.currentState);
          // 2 optimistic + 2 server tiles, optimistic first
          expect(tiles, hasLength(4));

          final uploading = tiles[0];
          expect(uploading.uploadStatus, TileUploadStatus.uploading);
          expect(uploading.uploadProgress, 42);
          expect(uploading.description, contains('Enviando'));
          expect(uploading.description, contains('42%'));

          final waiting = tiles[1];
          expect(waiting.uploadStatus, TileUploadStatus.waitingNetwork);
          expect(waiting.description, contains('Aguardando rede'));

          // server tiles keep their normal (non-upload) state
          expect(tiles[2].uploadStatus, isNull);
          expect(tiles[3].uploadStatus, isNull);
        },
      );
    });

    group('listen', () {
      test('playing a downloadable audio starts the player and flips state',
          () async {
        // arrange — the fixture's first audio has download_granted=1 (canPlay).
        await sut.loadPage();
        final tiles = loadedTiles(sut.currentState);
        final playable = tiles.firstWhere((t) => t.audio.canPlay);

        when(
          () => audioPlayServices.start(
            any(),
            onFinished: any(named: 'onFinished'),
          ),
        ).thenAnswer((_) async => right(playable.audio));

        // act — tap the play button on a playable tile (callback is void)
        playable.onPlayAudio(playable.audio);
        await untilCalled(
          () => audioPlayServices.start(
            any(),
            onFinished: any(named: 'onFinished'),
          ),
        );
        await Future<void>.delayed(Duration.zero); // let the fold settle state

        // assert — player invoked and state reflects playback
        verify(
          () => audioPlayServices.start(
            playable.audio,
            onFinished: any(named: 'onFinished'),
          ),
        ).called(1);

        final playingId = sut.playingAudioState.when(
          none: () => null,
          playing: (audio) => audio.id,
        );
        expect(playingId, playable.audio.id);
      });

      test('tapping a not-yet-granted audio requests access instead of playing',
          () async {
        // arrange — an audio that is neither playable nor already requested
        await sut.loadPage();
        final anyTile = loadedTiles(sut.currentState).first;
        final lockedAudio = AudioEntity(
          id: 'locked',
          audioDuration: '0m10s',
          createdAt: DateTime(2024, 1, 1),
          canPlay: false,
          isRequested: false,
          isRequestGranted: false,
        );

        when(() => audiosRepository.requestAccess(any())).thenAnswer(
          (_) async => right(const ValidField(message: 'Solicitação enviada')),
        );

        // act — reuse a real tile's play callback with the locked audio
        anyTile.onPlayAudio(lockedAudio);
        await untilCalled(() => audiosRepository.requestAccess(any()));

        // assert — goes through request-access, never starts the player
        verify(() => audiosRepository.requestAccess(lockedAudio)).called(1);
        verifyNever(
          () => audioPlayServices.start(
            any(),
            onFinished: any(named: 'onFinished'),
          ),
        );
      });
    });
  });
}
