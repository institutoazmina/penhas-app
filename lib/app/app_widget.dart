import 'package:asuka/asuka.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  static FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PenhaS',
      builder: Asuka.builder,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Lato'),
      ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      navigatorObservers: [
        observer,
        Asuka.asukaHeroController,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    ).modular();
  }
}
