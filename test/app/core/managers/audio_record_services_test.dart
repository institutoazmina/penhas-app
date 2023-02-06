import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/states/audio_permission_state.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

void main() {
  late AudioRecordServices recordServices;
  late IAudioSyncManager audioSyncManager;
  late FlutterSoundRecorder soundRecorder;

  setUpAll(() {
    registerFallbackValue(Duration(milliseconds: 100));
    registerFallbackValue(Codec.aacADTS);
  });

  setUp(() {
    audioSyncManager = MockAudioSyncManager();
    soundRecorder = MockFlutterSoundRecorder();

    PermissionHandlerPlatform.instance = MockPermissionHandlerPlatform();

    recordServices = AudioRecordServices(
      audioSyncManager: audioSyncManager,
      recorder: soundRecorder,
    );
  });

  group(AudioRecordServices, () {
    test(
      'permissionStatus correct translate PermissionStatus to AudioPermissionState',
      () async {
        // arrange
        final permissionMap = {
          PermissionStatus.denied: AudioPermissionState.denied(),
          PermissionStatus.granted: AudioPermissionState.granted(),
          PermissionStatus.restricted: AudioPermissionState.restricted(),
          PermissionStatus.permanentlyDenied:
              AudioPermissionState.permanentlyDenied(),
          PermissionStatus.limited: AudioPermissionState.undefined(),
        };

        permissionMap.forEach((key, value) async {
          final mockPermissionHandlerPlatform =
              PermissionHandlerPlatform.instance;
          debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
          when((() => mockPermissionHandlerPlatform.checkPermissionStatus(
              Permission.microphone))).thenAnswer((_) async => key);

          // act
          final result = await recordServices.permissionStatus();
          // assert
          expect(result, value,
              reason: 'Expect value $value for permission status $key');
        });
      },
    );

    test(
      'requestPermission return a AudioPermissionState.granted for PermissionStatus.granted',
      () async {
        // arrange
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.microphone)))
            .thenAnswer((_) async => PermissionStatus.granted);

        // act
        final result = await recordServices.requestPermission();

        // assert
        expect(result, AudioPermissionState.granted());
      },
    );

    test(
      'requestPermission return a AudioPermissionState.restricted for PermissionStatus.restricted',
      () async {
        // arrange
        final mockPermissionHandlerPlatform =
            PermissionHandlerPlatform.instance;
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

        when((() => mockPermissionHandlerPlatform
                .checkPermissionStatus(Permission.microphone)))
            .thenAnswer((_) async => PermissionStatus.restricted);

        // act
        final result = await recordServices.requestPermission();

        // assert
        expect(result, AudioPermissionState.restricted());
      },
    );

    test('dispose() release the audio record session', () async {
      when(() => soundRecorder.isStopped).thenReturn(false);
      when(() => audioSyncManager.syncAudio())..thenAnswer((_) async => true);
      when(() => soundRecorder.stopRecorder()).thenAnswer((_) async => null);
      when(() => soundRecorder.closeRecorder()).thenAnswer((_) async => null);

      // act
      await recordServices.dispose();

      // assert
      verify(() => soundRecorder.isStopped).called(1);
      verify(() => soundRecorder.stopRecorder()).called(1);
      verify(() => soundRecorder.closeRecorder()).called(1);
      verify(() => audioSyncManager.syncAudio()).called(1);
    });

    test('start() record audio for microphone permission granted', () async {
      // arrange
      final mockPermissionHandlerPlatform = PermissionHandlerPlatform.instance;
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

      when((() => mockPermissionHandlerPlatform
              .checkPermissionStatus(Permission.microphone)))
          .thenAnswer((_) async => PermissionStatus.granted);

      when(() => soundRecorder.isStopped).thenReturn(true);
      when(() => soundRecorder.openRecorder()).thenAnswer((_) async => null);
      when(() => soundRecorder.setSubscriptionDuration(any()))
          .thenAnswer((_) async => null);
      when(() => soundRecorder.startRecorder(
            codec: any(named: 'codec'),
            toFile: any(named: 'toFile'),
            bitRate: any(named: 'bitRate'),
            sampleRate: any(named: 'sampleRate'),
          )).thenAnswer((_) async => null);

      when(() => audioSyncManager.audioFile(
            session: any(named: 'session'),
            sequence: any(named: 'sequence'),
          )).thenAnswer((_) async => '/tmp/file_name.txt');

      // act
      await recordServices.start();

      // assert
      verify(() => soundRecorder.isStopped).called(1);
      verify(() => soundRecorder.closeRecorder()).called(1);
      verify(() => soundRecorder.openRecorder()).called(1);
      verify(() => soundRecorder.startRecorder(
          codec: any(named: 'codec'),
          toFile: any(named: 'toFile'),
          bitRate: any(named: 'bitRate'),
          sampleRate: any(named: 'sampleRate'))).called(1);
    });
  });
}

class MockAudioSyncManager extends Mock implements IAudioSyncManager {}

class MockFlutterSoundRecorder extends Mock implements FlutterSoundRecorder {}

class MockPermissionHandlerPlatform extends Mock
    with
        // ignore: prefer_mixin
        MockPlatformInterfaceMixin
    implements
        PermissionHandlerPlatform {}
