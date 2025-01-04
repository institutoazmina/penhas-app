import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/presentation/pages/widget/support_center_detail_map_widget.dart';

import '../../../../../../utils/widget_test_steps.dart';

class FakePlatformViewsController {
  FakePlatformGoogleMap? lastCreatedView;

  Future<dynamic> fakePlatformViewsMethodHandler(MethodCall call) {
    switch (call.method) {
      case 'create':
        final Map<dynamic, dynamic> args =
            call.arguments as Map<dynamic, dynamic>;
        final Map<dynamic, dynamic> params =
            _decodeParams(args['params'] as Uint8List)!;
        lastCreatedView = FakePlatformGoogleMap(args['id'] as int, params);
        return Future<int>.sync(() => 1);
      default:
        return Future<void>.sync(() {});
    }
  }

  void reset() {
    lastCreatedView = null;
  }
}

Map<dynamic, dynamic>? _decodeParams(Uint8List paramsMessage) {
  final ByteBuffer buffer = paramsMessage.buffer;
  final ByteData messageBytes = buffer.asByteData(
    paramsMessage.offsetInBytes,
    paramsMessage.lengthInBytes,
  );
  return const StandardMessageCodec().decodeMessage(messageBytes)
      as Map<dynamic, dynamic>?;
}

class FakePlatformGoogleMap {
  FakePlatformGoogleMap(int id, Map<dynamic, dynamic> params)
      : cameraPosition =
            CameraPosition.fromMap(params['initialCameraPosition']),
        channel = MethodChannel('plugins.flutter.io/google_maps_$id') {
    channel.setMockMethodCallHandler(onMethodCall);
  }

  MethodChannel channel;
  CameraPosition? cameraPosition;

  Future<dynamic> onMethodCall(MethodCall call) {
    return Future<void>.sync(() {});
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FakePlatformViewsController fakePlatformViewsController =
      FakePlatformViewsController();

  setUpAll(() {
    SystemChannels.platform_views.setMockMethodCallHandler(
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
  group(SupportCenterDetailMapWidget, () {
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
