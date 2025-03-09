import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_session_entity.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_controller.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_page.dart';

import '../../../../utils/fake_google_map_platform_views_controller.dart';
import '../../../../utils/golden_tests.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FakeGoogleMapPlatformViewsController fakePlatformViewsController =
      FakeGoogleMapPlatformViewsController();

  late SupportCenterUseCase supportCenterUseCase;
  late SupportCenterController controller;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views,
            fakePlatformViewsController.fakePlatformViewsMethodHandler);
    supportCenterUseCase = MockSupportCenterUseCase();
    controller = SupportCenterController(
      supportCenterUseCase: supportCenterUseCase,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeSupportCenterFetchRequest());
    // Override the GoogleMap widget with the mock version
    TestWidgetsFlutterBinding.ensureInitialized();
    // Note: We don't need to set GoogleMap.platform since we're using a mock widget
  });

  group(SupportCenterPage, () {
    screenshotTest(
      'should render error state when server fails',
      fileName: 'support_center_page_error_state',
      pageBuilder: () => SupportCenterPage(controller: controller),
      setUp: () {
        when(() => supportCenterUseCase.fetch(any())).thenAnswer(
          (_) => Future.value(dartz.Left(ServerFailure())),
        );
      },
    );

    screenshotTest(
      'should render success state with map and markers',
      fileName: 'support_center_page_success_state',
      pageBuilder: () => SupportCenterPage(controller: controller),
      setUp: () {
        when(() => supportCenterUseCase.fetch(any())).thenAnswer(
          (_) => Future.value(dartz.Right(centerPlace)),
        );
      },
    );
  });
}

class MockSupportCenterUseCase extends Mock implements SupportCenterUseCase {}

class FakeSupportCenterFetchRequest extends Fake
    implements SupportCenterFetchRequest {}

final centerPlace = SupportCenterPlaceSessionEntity(
  places: [
    SupportCenterPlaceEntity(
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
      rate: '0',
      ratedByClient: 0,
    )
  ],
  hasMore: false,
  nextPage: null,
  maximumRate: 5,
  latitude: -23.123,
  longitude: -46.123,
);
