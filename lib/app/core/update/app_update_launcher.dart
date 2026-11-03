import 'package:in_app_update/in_app_update.dart';
import 'package:platform/platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/logger/log.dart';

typedef ImmediateUpdate = Future<bool> Function();
typedef StoreLauncher = Future<bool> Function(Uri uri);

class AppUpdateLauncher {
  AppUpdateLauncher({
    Platform platform = const LocalPlatform(),
    ImmediateUpdate? immediateUpdate,
    StoreLauncher? storeLauncher,
  })  : _platform = platform,
        _immediateUpdate = immediateUpdate ?? _performImmediateUpdate,
        _storeLauncher = storeLauncher ?? _launchStore;

  static final Uri _playStoreUri = Uri.parse(
    'https://play.google.com/store/apps/details?id=penhas.com.br',
  );
  static final Uri _appStoreUri = Uri.parse(
    'https://apps.apple.com/br/app/penhas/id1441569466',
  );

  final Platform _platform;
  final ImmediateUpdate _immediateUpdate;
  final StoreLauncher _storeLauncher;

  Future<void> launch() async {
    if (_platform.isAndroid) {
      try {
        if (await _immediateUpdate()) return;
      } catch (error, stack) {
        logError(error, stack);
      }
    }

    try {
      await _storeLauncher(_platform.isIOS ? _appStoreUri : _playStoreUri);
    } catch (error, stack) {
      logError(error, stack);
    }
  }

  static Future<bool> _performImmediateUpdate() async {
    final updateInfo = await InAppUpdate.checkForUpdate();
    if (updateInfo.updateAvailability != UpdateAvailability.updateAvailable ||
        !updateInfo.immediateUpdateAllowed) {
      return false;
    }

    final result = await InAppUpdate.performImmediateUpdate();
    return result != AppUpdateResult.inAppUpdateFailed;
  }

  static Future<bool> _launchStore(Uri uri) => launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
}
