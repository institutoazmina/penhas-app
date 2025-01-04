import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/presentation/pages/widget/support_center_rate_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../../../utils/golden_tests.dart';

void main() {
  late SupportCenterPlaceDetailEntity entityDetail;

  setUp(() {
    entityDetail = SupportCenterPlaceDetailEntity(
      maximumRate: 5,
      ratedByClient: 3,
      place: const SupportCenterPlaceEntity(
        id: '1',
        rate: '4.5',
        ratedByClient: 100,
        distance: '2km',
        latitude: -23.550520,
        longitude: -46.633308,
        name: 'Test Place',
        uf: 'SP',
        fullStreet: 'Test Street, 123',
        category: SupportCenterPlaceCategoryEntity(
          id: 1,
          name: 'Test Category',
          color: '#FFFFFF',
        ),
        typeOfPlace: 'Test Type',
        htmlContent: '<p>Test content</p>',
      ),
    );
  });

  group(SupportCenterRateWidget, () {
    testWidgets(
      'should render SupportCenterRateWidget correctly',
      (WidgetTester tester) async {
        bool wasRated = false;
        double ratingValue = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SupportCenterRateWidget(
                detail: entityDetail,
                onRated: (rating) {
                  wasRated = true;
                  ratingValue = rating;
                },
              ),
            ),
          ),
        );

        // Verify title is displayed
        expect(find.text('Avaliações'), findsOneWidget);

        // Verify rating description is displayed
        expect(
          find.text(
            'Avalie esse ponto de apoio para ajudar mulheres em situações de violência.',
          ),
          findsOneWidget,
        );

        // Verify SmoothStarRating is displayed with correct initial rating
        final starRating = tester.widget<SmoothStarRating>(
          find.byType(SmoothStarRating),
        );
        expect(starRating.rating, equals(3.0));
        expect(starRating.size, equals(40.0));
        expect(starRating.allowHalfRating, isFalse);

        // Test rating callback
        await tester.tap(find.byType(SmoothStarRating));
        await tester.pumpAndSettle();

        expect(wasRated, isTrue);
        expect(ratingValue, equals(3.0));
      },
    );

    testWidgets(
      'should have correct styling',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SupportCenterRateWidget(
                detail: entityDetail,
                onRated: (_) {},
              ),
            ),
          ),
        );

        final titleFinder = find.text('Avaliações');
        final title = tester.widget<Text>(titleFinder);

        expect(title.style?.fontSize, equals(20.0));
        expect(title.style?.fontFamily, equals('Lato'));
        expect(title.style?.fontWeight, equals(FontWeight.bold));

        final container = tester.widget<Container>(find.byType(Container));
        expect(container.constraints?.maxHeight, equals(280));
      },
    );

    screenshotTest(
      'support_center_rate_widget',
      fileName: 'support_center_rate_widget',
      pageBuilder: () => SupportCenterRateWidget(
        detail: entityDetail,
        onRated: (_) {},
      ),
    );
  });
}
