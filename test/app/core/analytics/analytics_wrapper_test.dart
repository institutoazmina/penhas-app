import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/analytics/analytics_wrapper.dart';

void main() {
  group(AnalyticsWrapper, () {
    late AnalyticsWrapper sut;

    late FirebaseAnalytics analytics;

    setUp(() {
      analytics = _MockFirebaseAnalytics();
      sut = AnalyticsWrapper(analytics);
    });

    test(
      'setProperties should call setUserProperty for each property',
      () async {
        // arrange
        final properties = <String, dynamic>{
          'key1': 'value1',
          'key2': 'value2',
        };
        when(
          () => analytics.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => true);

        // act
        await sut.setProperties(properties);

        // assert
        verify(() => analytics.setUserProperty(name: 'key1', value: 'value1'))
            .called(1);
        verify(() => analytics.setUserProperty(name: 'key2', value: 'value2'))
            .called(1);
      },
    );
  });
}

class _MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}
