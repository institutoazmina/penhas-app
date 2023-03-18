import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:platform/platform.dart';

import '../managers/app_configuration.dart';

abstract class IApiServerConfigure {
  Uri get baseUri;
  Future<String?> get apiToken;
  Future<String> get userAgent;
}

class ApiServerConfigure implements IApiServerConfigure {
  ApiServerConfigure({
    required IAppConfiguration appConfiguration,
    Platform? platform,
  })  : _appConfiguration = appConfiguration,
        _platform = platform ?? const LocalPlatform();

  final IAppConfiguration _appConfiguration;
  final Platform _platform;

  @override
  Uri get baseUri => _appConfiguration.penhasServer;

  @override
  Future<String?> get apiToken => _appConfiguration.apiToken;

  @override
  Future<String> get userAgent => _userAgent();

  Future<String> _userAgent() async {
    final deviceInfo = await _deviceInfo();
    final appInfo = await _appInfo();

    return '$deviceInfo/$appInfo';
  }

  Future<String> _appInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> _deviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    _DeviceInfo deviceData = _DeviceInfo('Error', '0.0.0', 'Invalid Model');

    try {
      if (_platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (_platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch (_) {
      deviceData = _DeviceInfo('Error', '0.0.0', 'Invalid Model');
    }

    return '${deviceData.platform} ${deviceData.version}/${deviceData.model}';
  }

  _DeviceInfo _readAndroidBuildData(AndroidDeviceInfo build) {
    return _DeviceInfo(
      'Android',
      build.version.release,
      '${build.brand} ${build.model}',
    );
  }

  _DeviceInfo _readIosDeviceInfo(IosDeviceInfo data) {
    return _DeviceInfo('iOS', data.systemVersion, data.model);
  }
}

class _DeviceInfo {
  _DeviceInfo(this.platform, this.version, this.model);

  final String platform;
  final String version;
  final String model;
}
