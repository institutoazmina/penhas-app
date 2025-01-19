import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../../core/managers/location_services.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_server_configure.dart';
import '../../core/network/network_info.dart';
import '../../core/remoteconfig/i_remote_config.dart';
import '../../shared/navigation/app_navigator.dart';
import '../../shared/widgets/dialog_route.dart';
import '../appstate/domain/usecases/app_state_usecase.dart';
import '../help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';
import 'data/datasources/quiz_data_source.dart';
import 'data/repositories/quiz_repository.dart';
import 'domain/quiz_remote_config.dart';
import 'domain/repositories/i_quiz_repository.dart';
import 'domain/send_answer.dart';
import 'domain/start_quiz.dart';
import 'presentation/quiz/quiz_controller.dart';
import 'presentation/quiz/quiz_page.dart';
import 'presentation/quiz_start/quiz_start_controller.dart';
import 'presentation/quiz_start/quiz_start_page.dart';
import 'presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'presentation/tutorial/stealth_mode_tutorial_page_controller.dart';

class QuizModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory<IQuizController>(
          (i) => IQuizController.legacy(
            quiz: i.args?.data,
            sendAnswer: i.get<SendAnswerUseCase>(),
            remoteConfig: QuizRemoteConfig(
              remoteConfig: i.get<IRemoteConfigService>(),
            ),
            navigator: i.get<AppNavigator>(),
          ),
        ),
        Bind.factory<QuizStartController>(
          (i) => QuizStartController(
            sessionId: i.args?.queryParams['session_id'],
            startQuiz: i.get<StartQuizUseCase>(),
          ),
        ),
        Bind.factory<SendAnswerUseCase>(
          (i) => SendAnswerUseCase(
            repository: i.get<IQuizRepository>(),
            appStateUseCase: i.get<AppStateUseCase>(),
          ),
        ),
        Bind.factory<StartQuizUseCase>(
          (i) => StartQuizUseCase(
            repository: i.get<IQuizRepository>(),
          ),
        ),
        Bind.factory<QuizRemoteConfig>(
          (i) => QuizRemoteConfig(
            remoteConfig: i.get<IRemoteConfigService>(),
          ),
        ),
        Bind.factory<IQuizRepository>(
          (i) => QuizRepository(
            dataSource: i.get<IQuizDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind.factory<IQuizDataSource>(
          (i) => QuizDataSource(
            apiProvider: i.get<IApiProvider>(),
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<ILocationServices>(
          (i) => LocationServices(),
        ),
        Bind.factory<StealthModeTutorialPageController>(
          (i) => StealthModeTutorialPageController(
            locationService: i.get<ILocationServices>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, __) => const QuizPage(),
        ),
        ChildRoute(
          '/start',
          child: (_, args) => QuizStartPage(
            controller: Modular.get(),
          ),
          routeGenerator: dialogRouteGenerator,
        ),
        ChildRoute(
          '/tutorial/help-center',
          child: (_, __) => const GuardianTutorialPage(),
        ),
        ChildRoute(
          '/tutorial/stealth',
          child: (_, __) => const StealthModeTutorialPage(),
        ),
      ];
}
