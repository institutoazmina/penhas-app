import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/managers/audio_record_services.dart';
import 'package:penhas/app/core/managers/audio_sync_manager.dart';
import 'package:penhas/app/core/states/audio_permission_state.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late AudioRecordServices recordServices;
  late IAudioSyncManager audioSyncManager;
  late FlutterSoundRecorder soundRecorder;

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
