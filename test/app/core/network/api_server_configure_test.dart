import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:platform/platform.dart';

class MockAppConfiguration extends Mock implements IAppConfiguration {}

class MockPlatform extends Mock implements Platform {}

const packageInfoChannel = 'dev.fluttercommunity.plus/package_info';
const deviceInfoChannel = 'dev.fluttercommunity.plus/device_info';
void main() {
  late IAppConfiguration appConfiguration;
  late Platform platform;
  late ApiServerConfigure sut;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    appConfiguration = MockAppConfiguration();
    platform = MockPlatform();
    sut = ApiServerConfigure(
      appConfiguration: appConfiguration,
      platform: platform,
    );
  });
  group(ApiServerConfigure, () {
    test('return baseUri', () {
      // arrange
      final expected = Uri.parse('https://api.example.com');
      when(() => appConfiguration.penhasServer)
          .thenReturn(Uri.parse('https://api.example.com'));
      // action
      final actual = sut.baseUri;
      // assert
      expect(actual, expected);
    });

    test('return apiToken', () async {
      // arrange
      const expected = 'my_secret_token';
      when(() => appConfiguration.apiToken).thenAnswer((_) async => expected);
      // action
      final actual = await sut.apiToken;
      // assert
      expect(actual, expected);
    });

    test('crash return default userAgent', () async {
      // arrange
      const expected = 'Error 0.0.0/Invalid Model/42';
      const channelPackage = MethodChannel(packageInfoChannel);

      channelPackage.setMockMethodCallHandler((call) async {
        return {
          'appName': 'MyApp',
          'packageName': 'MyPackage',
          'version': '42',
          'buildNumber': '4242'
        };
      });

      // action
      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });

    test('in Android return userAgent with Android info', () async {
      // arrange
      const expected = 'Android release/Google model/42';
      const channelPackage = MethodChannel(packageInfoChannel);
      const channelDeviceInfo = MethodChannel(deviceInfoChannel);

      channelPackage.setMockMethodCallHandler((call) async {
        return {
          'appName': 'MyApp',
          'packageName': 'MyPackage',
          'version': '42',
          'buildNumber': '4242'
        };
      });
      when(() => platform.isAndroid).thenReturn(true);

      channelDeviceInfo.setMockMethodCallHandler((call) async {
        return _fakeAndroidDeviceInfo();
      });

      // action
      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });

    test('in iOS return userAgent with iOS info', () async {
      // arrange
      const expected = 'iOS systemVersion/model/42';
      const channelPackage = MethodChannel(packageInfoChannel);
      const channelDeviceInfo = MethodChannel(deviceInfoChannel);

      channelPackage.setMockMethodCallHandler((call) async {
        return {
          'appName': 'MyApp',
          'packageName': 'MyPackage',
          'version': '42',
          'buildNumber': '4242'
        };
      });
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isIOS).thenReturn(true);

      channelDeviceInfo.setMockMethodCallHandler((call) async {
        return _fakeiOSDeviceInfo();
      });

      // action
      final actual = await sut.userAgent;
      // assert
      expect(actual, expected);
    });
  });
}

Map<String, Object> _fakeiOSDeviceInfo() {
  const iosUtsnameMap = <String, dynamic>{
    'release': 'release',
    'version': 'version',
    'machine': 'machine',
    'sysname': 'sysname',
    'nodename': 'nodename',
  };
  return {
    'name': 'name',
    'model': 'model',
    'utsname': iosUtsnameMap,
    'systemName': 'systemName',
    'isPhysicalDevice': 'true',
    'systemVersion': 'systemVersion',
    'localizedModel': 'localizedModel',
    'identifierForVendor': 'identifierForVendor',
  };
}

Map<String, Object> _fakeAndroidDeviceInfo() {
  const fakeAndroidBuildVersion = {
    'sdkInt': 16,
    'baseOS': 'baseOS',
    'previewSdkInt': 30,
    'release': 'release',
    'codename': 'codename',
    'incremental': 'incremental',
    'securityPatch': 'securityPatch',
  };

  const fakeDisplayMetrics = {
    'widthPx': 1080.0,
    'heightPx': 2220.0,
    'xDpi': 530.0859,
    'yDpi': 529.4639,
  };

  const fakeSupportedAbis = ['arm64-v8a', 'x86', 'x86_64'];
  const fakeSupported32BitAbis = ['x86 (IA-32)', 'MMX'];
  const fakeSupported64BitAbis = ['x86-64', 'MMX', 'SSSE3'];
  const fakeSystemFeatures = ['FEATURE_AUDIO_PRO', 'FEATURE_AUDIO_OUTPUT'];

  return {
    'id': 'id',
    'host': 'host',
    'tags': 'tags',
    'type': 'type',
    'model': 'model',
    'board': 'board',
    'brand': 'Google',
    'device': 'device',
    'product': 'product',
    'display': 'display',
    'hardware': 'hardware',
    'isPhysicalDevice': true,
    'bootloader': 'bootloader',
    'fingerprint': 'fingerprint',
    'manufacturer': 'manufacturer',
    'supportedAbis': fakeSupportedAbis,
    'systemFeatures': fakeSystemFeatures,
    'version': fakeAndroidBuildVersion,
    'supported64BitAbis': fakeSupported64BitAbis,
    'supported32BitAbis': fakeSupported32BitAbis,
    'displayMetrics': fakeDisplayMetrics,
    'serialNumber': 'SERIAL',
  };
}
