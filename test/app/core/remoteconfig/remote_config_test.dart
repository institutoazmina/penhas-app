import 'dart:async';
import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/remoteconfig/remote_config.dart';

void main() {
  late _MockFirebaseRemoteConfig remoteConfig;
  late RemoteConfigService sut;

  setUpAll(() {
    registerFallbackValue(_FakeRemoteConfigSettings());
  });

  setUp(() {
    remoteConfig = _MockFirebaseRemoteConfig();
    RemoteConfigService.remoteConfig = remoteConfig;

    sut = RemoteConfigService();
  });

  group(RemoteConfigService, () {
    test(
      'getBool should call remote config getBool',
      () {
        final expected = Random().nextBool();
        when(() => remoteConfig.getBool(any())).thenReturn(expected);

        final result = sut.getBool('any_key');

        verify(() => remoteConfig.getBool('any_key')).called(1);
        expect(result, expected);
      },
    );

    test(
      'getInt should call remote config getInt',
      () {
        final expected = Random().nextInt(100);
        when(() => remoteConfig.getInt(any())).thenReturn(expected);

        final result = sut.getInt('any_key');

        verify(() => remoteConfig.getInt('any_key')).called(1);
        expect(result, expected);
      },
    );

    test(
      'getList should parse remote config getString as json list ignoring invalid values',
      () {
        const expected = ['foo', 'bar'];
        when(() => remoteConfig.getString(any()))
            .thenReturn('["foo", "bar", 0]');

        final result = sut.getList<String>('any_key');

        verify(() => remoteConfig.getString('any_key')).called(1);
        expect(result, expected);
      },
    );

    test(
      'getList when invalid list should return empty list',
      () {
        const expected = [];
        when(() => remoteConfig.getString(any())).thenReturn('"not a list"');

        final result = sut.getList<String>('any_key');

        verify(() => remoteConfig.getString('any_key')).called(1);
        expect(result, expected);
      },
    );

    test('setDefaults', () async {
      when(() => remoteConfig.setDefaults(any())).thenAnswer((_) async {});

      await sut.initialize();

      verify(
        () => remoteConfig.setDefaults(
          {
            'feature_login_offline': false,
            'feature_update_prompt': false,
            'feature_api_v2_authentication': false,
            'feature_api_v2_app_state': false,
            'feature_api_v2_account': false,
            'feature_api_v2_users': false,
            'feature_api_v2_feed': false,
            'feature_api_v2_chat': false,
            'feature_api_v2_notifications': false,
            'feature_api_v2_guardians': false,
            'feature_api_v2_audios': false,
            'feature_api_v2_support_center': false,
            'feature_api_v2_quiz': false,
            'feature_api_v2_escape_manual': false,
            'config_quiz_animation_duration': 400,
            'config_recommended_build_android': 0,
            'config_recommended_build_ios': 0,
          },
        ),
      ).called(1);
    });

    test('activate', () async {
      when(() => remoteConfig.setDefaults(any())).thenAnswer((_) async {});
      when(() => remoteConfig.setConfigSettings(any()))
          .thenAnswer((_) async {});

      await sut.initialize();

      final verifyResult =
          verify(() => remoteConfig.setConfigSettings(captureAny()));
      verifyResult.called(1);

      var resultConfig = verifyResult.captured.last;
      expect(resultConfig.fetchTimeout, const Duration(minutes: 1));
      expect(resultConfig.minimumFetchInterval, const Duration(hours: 1));
    });

    test('listens for real-time updates and activates them', () async {
      final updates = StreamController<RemoteConfigUpdate>();
      when(() => remoteConfig.setDefaults(any())).thenAnswer((_) async => {});
      when(() => remoteConfig.setConfigSettings(any()))
          .thenAnswer((_) async => {});
      when(() => remoteConfig.onConfigUpdated)
          .thenAnswer((_) => updates.stream);
      when(() => remoteConfig.fetchAndActivate()).thenAnswer((_) async => true);
      when(() => remoteConfig.activate()).thenAnswer((_) async => true);

      await sut.initialize();
      updates.add(RemoteConfigUpdate({'feature_api_v2_feed'}));
      await untilCalled(() => remoteConfig.activate());

      verify(() => remoteConfig.activate()).called(1);
      await updates.close();
    });

    test('refresh fetches and activates the latest config', () async {
      when(() => remoteConfig.fetchAndActivate()).thenAnswer((_) async => true);

      final result = await sut.refresh();

      expect(result, isTrue);
      verify(() => remoteConfig.fetchAndActivate()).called(1);
    });
  });
}

class _MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class _FakeRemoteConfigSettings extends Fake implements RemoteConfigSettings {}
