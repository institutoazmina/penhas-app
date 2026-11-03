import 'package:asuka/asuka.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/update/app_update_checker.dart';
import 'core/update/app_update_launcher.dart';
import 'core/update/app_update_prompt.dart';
import 'shared/design_system/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  static FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Modular.setObservers([
      observer,
      Asuka.asukaHeroController,
    ]);

    return MaterialApp.router(
      title: 'PenhaS',
      builder: (context, child) => Asuka.builder(
        context,
        AppUpdatePrompt(
          checker: Modular.get<AppUpdateChecker>(),
          launcher: Modular.get<AppUpdateLauncher>(),
          child: child ?? const SizedBox.shrink(),
        ),
      ),
      theme: AppTheme.of(context),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
