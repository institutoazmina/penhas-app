import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/remoteconfig/remote_config.dart';

class MockFirebaseRemoteConfig extends Mock implements FirebaseRemoteConfig {}

class MyRemoteConfigSettings extends Fake implements RemoteConfigSettings {}

void main() {
  late MockFirebaseRemoteConfig remoteConfig;
  late RemoteConfigService sut;

  setUp(() {
    remoteConfig = MockFirebaseRemoteConfig();
    sut = RemoteConfigService(remoteConfig: remoteConfig);
    registerFallbackValue(MyRemoteConfigSettings());
  });

  group(RemoteConfigService, () {
    test(
      'get bool values',
      () {
        const expected = false;
        when(() => remoteConfig.getBool('any_key')).thenReturn(expected);
        final result = sut.getBool('any_key');
        expect(result, expected);
      },
    );

    test('initialize remote config service', () {
      when(() => remoteConfig.fetch()).thenAnswer((_) async {
                    return Future.value(); 

      });
      when(() => remoteConfig.setConfigSettings(MyRemoteConfigSettings()))
          .thenAnswer((_) async {
                    return Future.value(); 
          });

      sut.setConfigSettings();
      verify(() => remoteConfig.setConfigSettings).called(1);
    });
  });
}
