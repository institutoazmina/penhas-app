import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:platform/platform.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockDeviceInfoPlugin extends Mock implements DeviceInfoPlugin {}

class MockAndroidDeviceInfo extends Mock implements AndroidDeviceInfo {}

class MockIosDeviceInfo extends Mock implements IosDeviceInfo {}

class MockAndroidBuildVersion extends Mock implements AndroidBuildVersion {}

void main() {
  late IAppConfiguration appConfiguration;
  late DeviceInfoPlugin deviceInfoPlugin;
  late AndroidDeviceInfo androidInfo;
  late IosDeviceInfo iosInfo;
  late AndroidBuildVersion androidBuildVersion;

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    appConfiguration = MockAppConfiguration();
    deviceInfoPlugin = MockDeviceInfoPlugin();
    androidInfo = MockAndroidDeviceInfo();
    iosInfo = MockIosDeviceInfo();
    androidBuildVersion = MockAndroidBuildVersion();

    // Setup for PackageInfo
    PackageInfo.setMockInitialValues(
      appName: 'MyApp',
      packageName: 'MyPackage',
      version: '42',
      buildNumber: '4242',
      buildSignature: 'buildSignature',
    );
  });

  group(ApiServerConfigure, () {
    // Helper function to create SUT with injected deviceInfoPlugin
    ApiServerConfigure createSut({Platform? platform}) {
      return ApiServerConfigure(
        appConfiguration: appConfiguration,
        platform: platform ?? FakePlatform(),
        deviceInfoPlugin: deviceInfoPlugin, // Inject the mock
      );
    }

    test('return baseUri', () {
      // arrange
      final expected = Uri.parse('https://api.example.com');
      when(() => appConfiguration.penhasServer)
          .thenReturn(Uri.parse('https://api.example.com'));
      final sut = createSut();
      // action
      final actual = sut.baseUri;
      // assert
      expect(actual, expected);
    });

    test('return apiToken', () async {
      // arrange
      const expected = 'my_secret_token';
      when(() => appConfiguration.apiToken).thenAnswer((_) async => expected);
      final sut = createSut();
      // action
      final actual = await sut.apiToken;
      // assert
      expect(actual, expected);
    });

    test('crash return default userAgent', () async {
      // arrange
      const expected = 'Error 0.0.0/Invalid Model/42';

      // Mock the deviceInfoPlugin to throw an exception
      when(() => deviceInfoPlugin.androidInfo)
          .thenThrow(Exception('Test exception'));
      when(() => deviceInfoPlugin.iosInfo)
          .thenThrow(Exception('Test exception'));

      // action
      final sut = createSut();

      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });

    test('in Android return userAgent with Android info', () async {
      // arrange
      const expected = 'Android release/Google model/42';

      // Setup Android device info mocks
      when(() => androidInfo.version).thenReturn(androidBuildVersion);
      when(() => androidBuildVersion.release).thenReturn('release');
      when(() => androidInfo.brand).thenReturn('Google');
      when(() => androidInfo.model).thenReturn('model');
      when(() => deviceInfoPlugin.androidInfo)
          .thenAnswer((_) async => androidInfo);

      final sut = createSut(platform: FakePlatform(operatingSystem: 'android'));

      // action
      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });

    test('in iOS return userAgent with iOS info', () async {
      // arrange
      const expected = 'iOS systemVersion/model/42';

      // Setup iOS device info mocks
      when(() => iosInfo.systemVersion).thenReturn('systemVersion');
      when(() => iosInfo.model).thenReturn('model');
      when(() => deviceInfoPlugin.iosInfo).thenAnswer((_) async => iosInfo);

      final sut = createSut(platform: FakePlatform(operatingSystem: 'ios'));

      // action
      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });
  });
}
