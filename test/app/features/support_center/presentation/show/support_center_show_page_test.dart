import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_module.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_entity.dart';
import 'package:penhas/app/features/support_center/domain/usecases/support_center_usecase.dart';
import 'package:penhas/app/features/support_center/presentation/pages/widget/support_center_detail_map_widget.dart';
import 'package:penhas/app/features/support_center/presentation/pages/widget/support_center_rate_widget.dart';
import 'package:penhas/app/features/support_center/presentation/show/support_center_show_page.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_module.dart';
import 'package:penhas/app/shared/design_system/widgets/buttons/penhas_button.dart';

import '../../../../../utils/fake_google_map_platform_views_controller.dart';
import '../../../../../utils/golden_tests.dart';

class MockSupportCenterUseCase extends Mock implements SupportCenterUseCase {}

class MockModularNavigate extends Mock implements IModularNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final FakeGoogleMapPlatformViewsController fakePlatformViewsController =
      FakeGoogleMapPlatformViewsController();

  late MockSupportCenterUseCase mockSupportCenterUseCase;

  setUp(() {
    SystemChannels.platform_views.setMockMethodCallHandler(
        fakePlatformViewsController.fakePlatformViewsMethodHandler);

    mockSupportCenterUseCase = MockSupportCenterUseCase();

    initModules(
      [
        AppModule(),
        MainboardModule(),
        SupportCenterModule(),
      ],
      replaceBinds: [
        Bind<SupportCenterUseCase>((i) => mockSupportCenterUseCase),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(AppModule());
    Modular.removeModule(MainboardModule());
    Modular.removeModule(SupportCenterModule());
  });

  group(SupportCenterShowPage, () {
    testWidgets('should show loading state when initial', (tester) async {
      // arrange
      when(() => mockSupportCenterUseCase.detail(any())).thenAnswer(
        (_) => Future.value(dz.left(ServerFailure())),
      );
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterShowPage(),
        ),
      );
      // assert
      expect(find.text('Carregando...'), findsOneWidget);
    });

    testWidgets('should show error state with retry button', (tester) async {
      // arrange
      const errorMessage =
          'O servidor está com problema neste momento, tente novamente.';
      when(() => mockSupportCenterUseCase.detail(any())).thenAnswer(
        (_) => Future.value(dz.left(ServerFailure())),
      );
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterShowPage(),
        ),
      );
      await tester.pumpAndSettle();
      clearInteractions(mockSupportCenterUseCase);
      // assert
      expect(find.text(errorMessage), findsOneWidget);
      // test retry button
      await tester.tap(find.byType(PenhasButton));
      verify(() => mockSupportCenterUseCase.detail(any())).called(1);
    });

    testWidgets('should show loaded state with place details', (tester) async {
      // arrange
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

      when(() => mockSupportCenterUseCase.detail(any())).thenAnswer(
        (_) => Future.value(dz.right(mockDetail)),
      );
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: SupportCenterShowPage(),
        ),
      );
      await tester.pumpAndSettle();
      // assert
      expect(find.text('Test Place'), findsOneWidget);
      expect(find.text('TEST CATEGORY | TEST TYPE'), findsOneWidget);
      expect(find.text('Traçar rota'), findsOneWidget);
      expect(find.byType(PenhasButton), findsOneWidget);
      expect(find.byType(SupportCenterDetailMapWidget), findsOneWidget);
      expect(find.byType(SupportCenterRateWidget), findsOneWidget);
    });
  });

  screenshotTest(
    'error state looks as expected',
    fileName: 'support_center_show_page_error',
    pageBuilder: () => SupportCenterShowPage(),
    setUp: () {
      when(() => mockSupportCenterUseCase.detail(any())).thenAnswer(
        (_) => Future.value(dz.left(ServerFailure())),
      );
    },
  );

  screenshotTest(
    'loaded state looks as expected',
    fileName: 'support_center_show_page_loaded',
    pageBuilder: () => SupportCenterShowPage(),
    setUp: () {
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

      when(() => mockSupportCenterUseCase.detail(any())).thenAnswer(
        (_) => Future.value(dz.right(mockDetail)),
      );
    },
  );
}