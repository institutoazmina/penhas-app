import 'package:penhas/app/features/quiz/presentation/quiz/quiz_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_page.dart';

class QuizModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => QuizController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => QuizPage()),
      ];

  static Inject get to => Inject<QuizModule>.of();
}
