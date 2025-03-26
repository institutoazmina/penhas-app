import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/presentation/pages/widget/support_center_detail_map_widget.dart';

import '../../../../../../utils/fake_google_map_platform_views_controller.dart';
import '../../../../../../utils/widget_test_steps.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FakeGoogleMapPlatformViewsController fakePlatformViewsController =
      FakeGoogleMapPlatformViewsController();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views,
            fakePlatformViewsController.fakePlatformViewsMethodHandler);
  });

  setUp(() {
    fakePlatformViewsController.reset();
  });

  final mockDetail = SupportCenterPlaceDetailEntity(
    place: SupportCenterPlaceEntity(
      ratedByClient: 0,
      rate: '0',
      id: '1',
      name: 'Test Place',
      distance: '0',
      fullStreet: 'Test Street',
      uf: 'SP',
      category: SupportCenterPlaceCategoryEntity(
        id: 1,
        name: 'Test Category',
        color: '#000000',
      ),
      typeOfPlace: 'Test Type',
      htmlContent: 'Test Content',
      latitude: -23.123,
      longitude: -46.123,
    ),
    maximumRate: 5,
    ratedByClient: 0,
  );
  group(SupportCenterDetailMapWidget, skip: true, () {
    testWidgets('should render GoogleMap with correct position',
        (tester) async {
      await tester.theAppIsRunning(
        SupportCenterDetailMapWidget(
          detail: mockDetail,
        ),
      );

      expect(find.byType(GoogleMap), findsOneWidget);
      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, 160);
    });
  });
}
