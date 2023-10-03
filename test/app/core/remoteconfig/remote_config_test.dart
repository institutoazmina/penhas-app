import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/remoteconfig/remote_config.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class MyRemoteConfigSettings extends Fake implements RemoteConfigSettings {}

void main() {
  late MockFirebaseRemoteConfig remoteConfig;
  late RemoteConfigService sut;
  RemoteConfigSettings myRemoteConfigSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  );

  setUp(() {
    remoteConfig = MockFirebaseRemoteConfig();
    sut = RemoteConfigService(remoteConfig: remoteConfig);
    registerFallbackValue(MyRemoteConfigSettings());
  });

  group(RemoteConfigService, () {
    test(
      'getBool',
      () {
        const expected = false;
        when(() => remoteConfig.getBool('any_key')).thenReturn(expected);
        final result = sut.getBool('any_key');
        expect(result, expected);
      },
    );

    test('setDefaults', () {
      when(() => remoteConfig.setDefaults({
            'feature_login_offline': false,
          })).thenAnswer((_) async {});

      sut.setDefaults();

      verify(() => remoteConfig.setDefaults({
            'feature_login_offline': false,
          })).called(1);
    });

    test('fetch', () {
      when(() => remoteConfig.fetch()).thenAnswer((_) async {});

      sut.fetch();
      verify(() => remoteConfig.fetch()).called(1);
    });

    test('initialize', () {
      when(() => remoteConfig.setConfigSettings(any()))
          .thenAnswer((_) async {});

      when(() => remoteConfig.activate()).thenAnswer((_) async {
        return true;
      });
      when(() => remoteConfig.fetch()).thenAnswer((_) async {});
      sut.initialize();
      verify(() => remoteConfig.fetch()).called(1);
    });
  });
}
