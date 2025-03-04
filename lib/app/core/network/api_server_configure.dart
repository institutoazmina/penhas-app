import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    DeviceInfoPlugin? deviceInfoPlugin,
  })  : _appConfiguration = appConfiguration,
        _platform = platform ?? const LocalPlatform(),
        _deviceInfoPlugin = deviceInfoPlugin ?? DeviceInfoPlugin();

  final IAppConfiguration _appConfiguration;
  final Platform _platform;
  final DeviceInfoPlugin _deviceInfoPlugin;

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
    _DeviceInfo deviceData = _DeviceInfo('Error', '0.0.0', 'Invalid Model');

    try {
      if (_platform.isAndroid) {
        deviceData = _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
      } else if (_platform.isIOS) {
        deviceData = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
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
    return _DeviceInfo(
      'iOS',
      data.systemVersion ?? '0.0.0',
      data.model ?? 'Invalid Model',
    );
  }
}

class _DeviceInfo {
  _DeviceInfo(this.platform, this.version, this.model);

  final String platform;
  final String version;
  final String model;
}
