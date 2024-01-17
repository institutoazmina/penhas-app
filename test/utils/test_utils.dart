import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  enableWarnWhenNoObservables = false;
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();

  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isCi,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}
