import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/authentication/domain/usecases/login_offline_toggle.dart';

class MockRemoteConfig extends Mock implements IRemoteConfigService {}

void main() {
  late MockRemoteConfig remoteConfig;
  late LoginOfflineToggleFeature sut;

  setUp(() {
    remoteConfig = MockRemoteConfig();
    sut = LoginOfflineToggleFeature(remoteConfig: remoteConfig);
  });

  group(LoginOfflineToggleFeature, () {
    test('return toggle value', () {
      when(() => remoteConfig.getBool('feature_login_offline'))
          .thenReturn(true);

      final result = sut.isEnabled;
      expect(result, true);
    });
    test('raises error and return false', () {
      when(() => remoteConfig.getBool('feature_login_offline'))
          .thenThrow(Error());

      final result = sut.isEnabled;
      expect(result, false);
    });
  });
}
