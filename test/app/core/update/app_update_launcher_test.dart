import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/update/app_update_launcher.dart';
import 'package:platform/platform.dart';

void main() {
  group(AppUpdateLauncher, () {
    test('uses the Android immediate update when it is handled', () async {
      var storeLaunches = 0;
      final launcher = AppUpdateLauncher(
        platform: FakePlatform(operatingSystem: 'android'),
        immediateUpdate: () async => true,
        storeLauncher: (_) async {
          storeLaunches++;
          return true;
        },
      );

      await launcher.launch();

      expect(storeLaunches, 0);
    });

    test('falls back to Google Play when immediate update is unavailable',
        () async {
      Uri? launchedUri;
      final launcher = AppUpdateLauncher(
        platform: FakePlatform(operatingSystem: 'android'),
        immediateUpdate: () async => false,
        storeLauncher: (uri) async {
          launchedUri = uri;
          return true;
        },
      );

      await launcher.launch();

      expect(
        launchedUri,
        Uri.parse(
            'https://play.google.com/store/apps/details?id=penhas.com.br'),
      );
    });

    test('falls back to Google Play when immediate update fails', () async {
      Uri? launchedUri;
      final launcher = AppUpdateLauncher(
        platform: FakePlatform(operatingSystem: 'android'),
        immediateUpdate: () => throw StateError('Play API unavailable'),
        storeLauncher: (uri) async {
          launchedUri = uri;
          return true;
        },
      );

      await launcher.launch();

      expect(
        launchedUri,
        Uri.parse(
            'https://play.google.com/store/apps/details?id=penhas.com.br'),
      );
    });

    test('opens the App Store directly on iOS', () async {
      var immediateUpdates = 0;
      Uri? launchedUri;
      final launcher = AppUpdateLauncher(
        platform: FakePlatform(operatingSystem: 'ios'),
        immediateUpdate: () async {
          immediateUpdates++;
          return true;
        },
        storeLauncher: (uri) async {
          launchedUri = uri;
          return true;
        },
      );

      await launcher.launch();

      expect(immediateUpdates, 0);
      expect(
        launchedUri,
        Uri.parse('https://apps.apple.com/br/app/penhas/id1441569466'),
      );
    });
  });
}
