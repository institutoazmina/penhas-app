import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsWrapper {
  AnalyticsWrapper([FirebaseAnalytics? analytics])
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  FutureOr<void> setProperties(Map<String, dynamic> properties) async {
    for (var element in properties.entries) {
      await _analytics.setUserProperty(
        name: element.key,
        value: element.value?.toString(),
      );
    }
  }
}
