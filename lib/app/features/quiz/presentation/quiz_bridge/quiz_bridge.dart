import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/quiz_remote_config.dart';
import '../new_quiz/quiz_page.dart';
import '../quiz/quiz_page.dart';

class QuizBridgeBuilder {
  const QuizBridgeBuilder();

  Widget call(BuildContext context, ModularArguments args) {
    final remoteConfig = Modular.get<QuizRemoteConfig>();
    final data = args.data is Map ? args.data!['origin'] : null;
    final origin = args.queryParams['origin'] ?? data;

    if (remoteConfig.isEnabledForOrigin(origin)) {
      return const NewQuizPage();
    }

    return const QuizPage();
  }
}
