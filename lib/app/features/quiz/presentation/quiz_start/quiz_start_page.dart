import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import 'quiz_start_controller.dart';

class QuizStartPage extends StatefulWidget {
  const QuizStartPage({Key? key}) : super(key: key);

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState
    extends ModularState<QuizStartPage, QuizStartController> {
  @override
  Widget build(BuildContext context) {
    controller.start();

    return const PageProgressIndicator(
      progressMessage: 'Carregando...',
      progressState: PageProgressState.loading,
      child: SizedBox.shrink(),
    );
  }
}
