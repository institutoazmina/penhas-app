import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/core/remoteconfig/i_remote_config.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';
import 'package:penhas/app/features/quiz/presentation/quiz_bridge/quiz_bridge.dart';
import 'package:penhas/app/features/quiz/quiz_module.dart';
import 'package:penhas/app/shared/navigation/app_navigator.dart';

import '../../../../../utils/aditional_bind_module.dart';

void main() {
  group(QuizBridgeBuilder, () {
    late Widget sut;

    late Module mockModule;
    late ModularArguments args;
    late IModularNavigator mockNavigator;
    late IRemoteConfigService mockRemoteConfig;

    setUp(() {
      sut = _TestQuizBridgeBuilder();
      mockRemoteConfig = _MockRemoteConfigService();
      args = ModularArguments.empty();

      Modular.navigatorDelegate = mockNavigator = _MockModularNavigate();

      mockModule = AditionalBindModule(binds: [
        Bind<ModularArguments>((_) => args),
      ]);

      initModules(
        [AppModule(), QuizModule(), mockModule],
        replaceBinds: [
          Bind<AppStateUseCase>((i) => _MockAppStateUseCase()),
          Bind<IRemoteConfigService>((_) => mockRemoteConfig),
          Bind<INetworkInfo>((i) => _MockNetworkInfo()),
          Bind<IApiServerConfigure>((i) => _MockApiServerConfigure()),
          Bind<http.Client>((i) => _MockHttpClient()),
          Bind<IApiProvider>((i) => _MockApiProvider()),
          Bind<AppNavigator>((i) => AppNavigator()),
        ],
      );

      when(() => mockNavigator.args).thenReturn(
        ModularArguments(
          data: QuizSessionEntity(sessionId: 'SID'),
        ),
      );
    });

    tearDown(() {
      Modular.removeModule(AppModule());
      Modular.removeModule(QuizModule());
      Modular.removeModule(mockModule);
    });

    testWidgets(
      'should build a QuizPage when remoteConfig is not enabled',
      (tester) async {
        // arrange
        when(() => mockRemoteConfig.getBool(any())).thenReturn(false);

        // act
        await tester.pumpWidget(sut);

        // assert
        expect(find.byType(QuizPage), findsOneWidget);
      },
    );

    testWidgets(
      'should build a NewQuizPage when remoteConfig is enabled',
      (tester) async {
        // arrange
        when(() => mockRemoteConfig.getBool(any())).thenReturn(true);
        when(() => mockRemoteConfig.getList<String>(any())).thenReturn([]);

        // act
        await tester.pumpWidget(sut);

        // assert
        expect(find.byKey(const Key('new-quiz-placeholder')), findsOneWidget);
      },
    );

    testWidgets(
      'given queryParams should build a QuizPage when remoteConfig is enabled and origin is not enabled',
      (tester) async {
        // arrange
        args = ModularArguments(uri: Uri.parse('/?origin=origin'));
        when(() => mockRemoteConfig.getBool(any())).thenReturn(true);
        when(() => mockRemoteConfig.getList<String>(any()))
            .thenReturn(['origin']);

        // act
        await tester.pumpWidget(sut);

        // assert
        expect(find.byType(QuizPage), findsOneWidget);
      },
    );

    testWidgets(
      'should data build a QuizPage when remoteConfig is enabled and origin is not enabled',
      (tester) async {
        // arrange
        args = ModularArguments(data: {'origin': 'origin'});
        when(() => mockRemoteConfig.getBool(any())).thenReturn(true);
        when(() => mockRemoteConfig.getList<String>(any()))
            .thenReturn(['origin']);

        // act
        await tester.pumpWidget(sut);

        // assert
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

class _MockRemoteConfigService extends Mock implements IRemoteConfigService {}

class _TestQuizBridgeBuilder extends StatelessWidget {
  const _TestQuizBridgeBuilder();

  @override
  Widget build(BuildContext context) {
    final args = Modular.get<ModularArguments>();
    final builder = QuizBridgeBuilder();
    return buildTestableWidget(builder(context, args));
  }
}
