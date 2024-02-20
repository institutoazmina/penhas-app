import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/storage/persistent_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/feed/presentation/feed_page.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';

import '../../../../../utils/module_testing.dart';

void main() {
  group(MainboardPage, () {
    late IAppModulesServices mockAppModulesServices;
    late IApiProvider mockApiProvider;

    late List<Bind> overrides = [
      Bind<IApiProvider>((i) => mockApiProvider),
      Bind<IAppModulesServices>((i) => mockAppModulesServices),
      Bind<IPersistentStorageFactory>((i) => _MockPersistentStorageFactory()),
      Bind<IPersistentStorage>((i) => _MocLocalStorage()),
      Bind<MainboardController>(
        (i) => MainboardController(
          inactivityLogoutUseCase: i(),
          mainboardStore: i(),
          notification: i(),
          notificationTimer: _FakeTimer(),
        ),
      ),
    ];

    setUp(() {
      mockAppModulesServices = _MockAppModulesServices();
      mockApiProvider = _MockApiProvider();

      when(() => mockApiProvider.get(path: '/me/unread-notif-count'))
          .thenAnswer((_) async => '{"count": 0}');

      when(() => mockAppModulesServices.feature(name: any(named: 'name')))
          .thenAnswer((_) async => _FakeAppStateModuleEntity());
      when(() => mockAppModulesServices.isEnabled(any()))
          .thenAnswer((_) async => true);
    });

    testWidgets(
      'initial route should display FeedPage',
      (tester) async {
        // act
        await tester.pumpFrames(
          buildTestableApp(
            initialRoute: '/mainboard',
            overrides: overrides,
          ),
          Duration(milliseconds: 100),
        );

        // assert
        expect(find.byType(FeedPage), findsOneWidget);
      },
    );
  });
}

class _MockApiProvider extends Mock implements IApiProvider {}

class _MockAppModulesServices extends Mock implements IAppModulesServices {}

class _MockPersistentStorageFactory extends Mock
    implements IPersistentStorageFactory {}

class _MocLocalStorage extends Mock implements IPersistentStorage {}

class _FakeAppStateModuleEntity extends Fake implements AppStateModuleEntity {}

class _FakeTimer extends Fake implements Timer {}
