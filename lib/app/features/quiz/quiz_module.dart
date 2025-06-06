import 'package:flutter_modular/flutter_modular.dart';

import '../../core/managers/location_services.dart';
import '../../core/network/api_client.dart';
import '../../core/remoteconfig/i_remote_config.dart';
import '../../shared/navigation/app_navigator.dart';
import '../appstate/domain/usecases/app_state_usecase.dart';
import '../escape_manual/domain/entity/quiz_page_args.dart';
import '../help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';
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
        Bind.factory<IQuizController>((i) {
          final args = i.args.data as QuizPageArgs;
          return IQuizController.legacy(
            quiz: args.session,
            sendAnswer: i.get<SendAnswerUseCase>(),
            remoteConfig: QuizRemoteConfig(
              remoteConfig: i.get<IRemoteConfigService>(),
            ),
            navigator: i.get<AppNavigator>(),
          );
        }),
        Bind.factory<QuizStartController>(
          (i) => QuizStartController(
            sessionId: i.args.queryParams['session_id'],
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
          (i) => QuizRepository(apiProvider: i.get<IApiProvider>()),
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
          child: (_, __) => QuizPage(
            controller: Modular.get<IQuizController>(),
          ),
        ),
        ChildRoute(
          '/start',
          child: (_, args) => QuizStartPage(
            controller: Modular.get(),
          ),
        ),
        ChildRoute(
          '/tutorial/help-center',
          child: (_, __) => const GuardianTutorialPage(),
        ),
        ChildRoute(
          '/tutorial/stealth',
          child: (_, __) => StealthModeTutorialPage(
            controller: Modular.get<StealthModeTutorialPageController>(),
          ),
        ),
      ];
}
