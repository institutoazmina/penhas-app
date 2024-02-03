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

    sut = const RemoteConfigService();
  });

  group(RemoteConfigService, () {
    test(
      'getBool should call remote config getBool',
      () {
        const expected = false;
        when(() => remoteConfig.getBool(any())).thenReturn(expected);

        final result = sut.getBool('any_key');

        verify(() => remoteConfig.getBool('any_key')).called(1);
        expect(result, expected);
      },
    );

    test('setDefaults', () async {
      when(() => remoteConfig.setDefaults({
            'feature_login_offline': false,
          })).thenAnswer((_) async {});

      await sut.initialize();

      verify(() => remoteConfig.setDefaults({
            'feature_login_offline': false,
          })).called(1);
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

    test('activate', () async {
      when(() => remoteConfig.setDefaults(any())).thenAnswer((_) async => {});
      when(() => remoteConfig.setConfigSettings(any()))
          .thenAnswer((_) async => {});

      when(() => remoteConfig.activate()).thenAnswer((_) async => true);

      await sut.initialize();
      verify(() => remoteConfig.activate()).called(1);
    });

    test('fetch', () async {
      when(() => remoteConfig.setDefaults(any())).thenAnswer((_) async => {});
      when(() => remoteConfig.setConfigSettings(any()))
          .thenAnswer((_) async => {});
      when(() => remoteConfig.activate()).thenAnswer((_) async => true);
      when(() => remoteConfig.fetch()).thenAnswer((_) async => {});

      await sut.initialize();
      verify(() => remoteConfig.fetch()).called(1);
    });
  });
}

class _MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class _FakeRemoteConfigSettings extends Fake implements RemoteConfigSettings {}
