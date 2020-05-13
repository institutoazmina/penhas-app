import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';

abstract class IApiServerConfigure {
  Uri get baseUri;
  Future<String> get apiToken;
  Future<String> get userAgent;
}

class ApiServerConfigure implements IApiServerConfigure {
  final IAppConfiguration _appConfiguration;

  ApiServerConfigure({@required IAppConfiguration appConfiguration})
      : this._appConfiguration = appConfiguration;

  @override
  Uri get baseUri => _appConfiguration.penhasServer;

  @override
  Future<String> get apiToken => _appConfiguration.apiToken;

  @override
  Future<String> get userAgent => _userAgent();

  Future<String> _userAgent() async {
    final deviceInfo = await _deviceInfo();
    final appInfo = await _appInfo();

    return "$deviceInfo/$appInfo";
  }

  Future<String> _appInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> _deviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    _DeviceInfo deviceData;

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = _DeviceInfo('Error', '0.0.0', 'Invalid Model');
    }

    return "${deviceData.plataform} ${deviceData.version}/${deviceData.model}";
  }

  _DeviceInfo _readAndroidBuildData(AndroidDeviceInfo build) {
    return _DeviceInfo(
        'Android', build.version.release, "${build.brand} ${build.model}");
  }

  _DeviceInfo _readIosDeviceInfo(IosDeviceInfo data) {
    return _DeviceInfo('iOS', data.systemVersion, data.model);
  }
}

class _DeviceInfo {
  final String plataform;
  final String version;
  final String model;

  _DeviceInfo(this.plataform, this.version, this.model);
}
