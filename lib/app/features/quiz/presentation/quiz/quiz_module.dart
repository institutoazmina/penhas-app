import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../../../../core/managers/location_services.dart';
import '../../../../core/network/api_server_configure.dart';
import '../../../../core/network/network_info.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../../data/datasources/quiz_data_source.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../domain/repositories/i_quiz_repository.dart';
import '../tutorial/stealth_mode_tutorial_page_controller.dart';
import 'quiz_controller.dart';
import 'quiz_page.dart';

class QuizModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
          (i) => QuizController(
            quizSession: i.args?.data,
            appStateUseCase: i.get<AppStateUseCase>(),
            repository: i.get<IQuizRepository>(),
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
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        ),
        Bind.factory<ILocationServices>(
          (i) => LocationServices(),
                  ),
        Bind.factory<StealthModeTutorialPageController>(
          (i) => StealthModeTutorialPageController(
              locationService: i.get<ILocationServices>(),),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => const QuizPage()),
      ];
}
