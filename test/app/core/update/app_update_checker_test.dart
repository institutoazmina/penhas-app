import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/core/update/app_update_checker.dart';
import 'package:platform/platform.dart';

void main() {
  late _MockRemoteConfig remoteConfig;

  setUp(() {
    remoteConfig = _MockRemoteConfig();
    when(() => remoteConfig.refresh()).thenAnswer((_) async => true);
    when(() => remoteConfig.getBool(any())).thenReturn(true);
  });

  AppUpdateChecker createChecker({
    String operatingSystem = 'android',
    String buildNumber = '71',
    bool forcePrompt = false,
  }) {
    return AppUpdateChecker(
      remoteConfig: remoteConfig,
      platform: FakePlatform(operatingSystem: operatingSystem),
      packageInfoLoader: () async => PackageInfo(
        appName: 'PenhaS',
        packageName: 'penhas.com.br',
        version: '3.7.4',
        buildNumber: buildNumber,
      ),
      forcePrompt: forcePrompt,
    );
  }

  group(AppUpdateChecker, () {
    test('prompts when Android build is below the recommended build', () async {
      when(
        () => remoteConfig.getInt(
          RemoteConfigKeys.configRecommendedBuildAndroid,
        ),
      ).thenReturn(72);

      final result = await createChecker().shouldPrompt();

      expect(result, isTrue);
    });

    test('does not prompt when iOS build meets the recommended build',
        () async {
      when(
        () => remoteConfig.getInt(
          RemoteConfigKeys.configRecommendedBuildIos,
        ),
      ).thenReturn(71);

      final result = await createChecker(
        operatingSystem: 'ios',
      ).shouldPrompt();

      expect(result, isFalse);
    });

    test('does not prompt when the feature is disabled', () async {
      when(() => remoteConfig.getBool(any())).thenReturn(false);

      final result = await createChecker().shouldPrompt();

      expect(result, isFalse);
      verifyNever(() => remoteConfig.getInt(any()));
    });

    test('does not prompt for an invalid installed build number', () async {
      when(() => remoteConfig.getInt(any())).thenReturn(72);

      final result = await createChecker(
        buildNumber: 'invalid',
      ).shouldPrompt();

      expect(result, isFalse);
    });

    test('supports a test prompt override without fetching config', () async {
      final result = await createChecker(forcePrompt: true).shouldPrompt();

      expect(result, isTrue);
      verifyNever(() => remoteConfig.refresh());
    });
  });
}

class _MockRemoteConfig extends Mock implements IRemoteConfigService {}
