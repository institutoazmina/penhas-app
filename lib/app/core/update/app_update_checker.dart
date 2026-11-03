import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform/platform.dart';

import '../remoteconfig/i_remote_config.dart';

typedef PackageInfoLoader = Future<PackageInfo> Function();

class AppUpdateChecker {
  AppUpdateChecker({
    required IRemoteConfigService remoteConfig,
    Platform platform = const LocalPlatform(),
    PackageInfoLoader? packageInfoLoader,
    bool? forcePrompt,
  })  : _remoteConfig = remoteConfig,
        _platform = platform,
        _packageInfoLoader =
            packageInfoLoader ?? (() => PackageInfo.fromPlatform()),
        _forcePrompt = forcePrompt ??
            const bool.fromEnvironment('FORCE_APP_UPDATE_PROMPT');

  final IRemoteConfigService _remoteConfig;
  final Platform _platform;
  final PackageInfoLoader _packageInfoLoader;
  final bool _forcePrompt;

  Future<bool> shouldPrompt() async {
    if (_forcePrompt) return true;

    await _remoteConfig.refresh();

    if (!_remoteConfig.getBool(RemoteConfigKeys.featureUpdatePrompt)) {
      return false;
    }

    final recommendedBuild = _recommendedBuild;
    if (recommendedBuild <= 0) return false;

    final packageInfo = await _packageInfoLoader();
    final installedBuild = int.tryParse(packageInfo.buildNumber);

    return installedBuild != null && installedBuild < recommendedBuild;
  }

  int get _recommendedBuild {
    if (_platform.isAndroid) {
      return _remoteConfig.getInt(
        RemoteConfigKeys.configRecommendedBuildAndroid,
      );
    }

    if (_platform.isIOS) {
      return _remoteConfig.getInt(
        RemoteConfigKeys.configRecommendedBuildIos,
      );
    }

    return 0;
  }
}
