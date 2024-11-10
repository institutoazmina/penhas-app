import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';
import 'package:penhas/app/features/quiz/presentation/quiz_start/quiz_start_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../../utils/module_testing.dart';

void main() {
  group(QuizModule, () {
    late IModularNavigator mockNavigator;

    setUpAll(() {
      registerFallbackValue(_FakePermission());
    });

    setUp(() {
      Modular.navigatorDelegate = mockNavigator = _MockModularNavigate();
    });

    testWidgets(
      'should start StealthModeTutorialPage widget successfully',
      (tester) async {
        // arrange
        final permissionHandler = _MockPermissionHandlerPlatform();
        PermissionHandlerPlatform.instance = permissionHandler;
        when(() => permissionHandler.checkPermissionStatus(any())).thenAnswer(
          (_) async => PermissionStatus.granted,
        );

        // act
        await tester.pumpWidget(
          buildTestableApp(
            initialRoute: '/tutorial/stealth',
            modules: [QuizModule()],
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.byType(StealthModeTutorialPage), findsOneWidget);
      },
    );

    testWidgets(
      'should start GuardianTutorialPage widget successfully',
      (tester) async {
        // act
        await tester.pumpWidget(
          buildTestableApp(
            initialRoute: '/tutorial/help-center',
            modules: [QuizModule()],
          ),
        );
        await tester.pumpAndSettle();

        // assert
        expect(find.byType(GuardianTutorialPage), findsOneWidget);
      },
    );

    testWidgets(
      'route /start should start with QuizStartPage widget',
      (tester) async {
        // arrange
        when(
          () => mockNavigator.pushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(
          buildTestableApp(
            initialRoute: '/start',
            modules: [QuizModule()],
            overrides: [
              Bind.factory<AppStateUseCase>(
                (i) => _MockAppStateUseCase(),
              ),
              Bind.factory<INetworkInfo>(
                (i) => _MockNetworkInfo(),
              ),
              Bind.factory<IApiServerConfigure>(
                (i) => _MockApiServerConfigure(),
              ),
              Bind.factory<http.Client>(
                (i) => _MockHttpClient(),
              ),
              Bind.factory<IApiProvider>(
                (i) => _MockApiProvider(),
              ),
            ],
          ),
        );

        // act
        await tester.pump();

        // assert
        expect(find.byType(QuizStartPage), findsOneWidget);
      },
    );

    /// I don't know why but this test must be the last one
    /// If it is not the last one, the next test will fail
    /// Maybe some bug in the flutter_modular package
    testWidgets(
      'initial route should be QuizPage widget',
      (tester) async {
        // arrange
        final mockRemoteConfig = _MockRemoteConfig();
        when(() => mockRemoteConfig.getBool(any())).thenReturn(true);
        when(() => mockRemoteConfig.getInt(any())).thenReturn(42);
        when(() => mockRemoteConfig.getList<String>(any())).thenReturn([]);
        when(() => mockNavigator.args).thenReturn(
          ModularArguments(
            data: QuizSessionEntity(
              sessionId: 'SID',
              currentMessage: [],
              endScreen: null,
              isFinished: false,
            ),
          ),
        );
        when(
          () => mockNavigator.pushNamed(
            any(),
            arguments: any(named: 'arguments'),
          ),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(
          buildTestableApp(
            initialRoute: '/',
            modules: [QuizModule()],
            overrides: [
              Bind<AppStateUseCase>((i) => _MockAppStateUseCase()),
              Bind<INetworkInfo>((i) => _MockNetworkInfo()),
              Bind<IApiServerConfigure>((i) => _MockApiServerConfigure()),
              Bind<http.Client>((i) => _MockHttpClient()),
              Bind<IApiProvider>((i) => _MockApiProvider()),
              Bind<AppNavigator>((i) => AppNavigator()),
              Bind<IRemoteConfigService>((i) => mockRemoteConfig),
            ],
          ),
        );

        // act
        await tester.pump();

        // assert
        // will be replaced by the QuizPage widget soon
        expect(find.byType(QuizPage), findsOneWidget);
      },
    );
  });
}

class _MockModularNavigate extends Mock implements IModularNavigator {}

class _MockAppStateUseCase extends Mock implements AppStateUseCase {}

class _MockNetworkInfo extends Mock implements INetworkInfo {}

class _MockApiServerConfigure extends Mock implements IApiServerConfigure {}

class _MockHttpClient extends Mock implements http.Client {}

class _MockApiProvider extends Mock implements IApiProvider {}

class _MockRemoteConfig extends Mock implements IRemoteConfigService {}

class _MockPermissionHandlerPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PermissionHandlerPlatform {}

class _FakePermission extends Fake implements Permission {}
