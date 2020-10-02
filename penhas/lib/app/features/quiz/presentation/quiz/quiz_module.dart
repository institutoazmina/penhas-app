import 'package:http/http.dart' as http;
import 'package:penhas/app/core/network/api_server_configure.dart';
import 'package:penhas/app/core/network/network_info.dart';
import 'package:penhas/app/features/quiz/data/datasources/quiz_data_source.dart';
import 'package:penhas/app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:penhas/app/features/quiz/domain/repositories/i_quiz_repository.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';

class QuizModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => QuizController(
            quizSession: i.args.data,
            repository: i.get<IQuizRepository>(),
          ),
        ),
        Bind<IQuizRepository>(
          (i) => QuizRepository(
            dataSource: i.get<IQuizDataSource>(),
            networkInfo: i.get<INetworkInfo>(),
          ),
        ),
        Bind<IQuizDataSource>(
          (i) => QuizDataSource(
            apiClient: i.get<http.Client>(),
            serverConfiguration: i.get<IApiServerConfigure>(),
          ),
        )
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => QuizPage()),
      ];

  static Inject get to => Inject<QuizModule>.of();
}
