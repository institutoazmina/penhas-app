import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:penhas/app/shared/design_system/theme.dart';

Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await loadAppFonts();

  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      theme: AppTheme.from(ThemeData.light()),
      platformGoldensConfig: PlatformGoldensConfig(
        enabled: !isCi,
      ),
      ciGoldensConfig: CiGoldensConfig(
        obscureText: false,
        renderShadows: true,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}
