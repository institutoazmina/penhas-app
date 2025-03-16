import 'package:asuka/asuka.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/design_system/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

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
      builder: Asuka.builder,
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
