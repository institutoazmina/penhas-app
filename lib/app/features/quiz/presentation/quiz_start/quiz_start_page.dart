import 'package:flutter/material.dart';

import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import 'quiz_start_controller.dart';

class QuizStartPage extends StatefulWidget {
  const QuizStartPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final QuizStartController controller;

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  _QuizStartPageState();

  QuizStartController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return const PageProgressIndicator(
      progressMessage: 'Carregando...',
      progressState: PageProgressState.loading,
      child: SizedBox.shrink(),
    );
  }
}
