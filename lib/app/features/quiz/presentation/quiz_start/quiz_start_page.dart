import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../support_center/presentation/pages/support_center_general_error.dart';
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
    controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: DesignSystemColors.ligthPurple,
        centerTitle: true,
        title: const SizedBox(
          width: 39,
          height: 18,
          child: Image(
            image: AssetImage(
              'assets/images/penhas_symbol/penhas_symbol.png',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) => PageProgressIndicator(
            progressMessage: 'Carregando...',
            progressState: controller.progressState,
            child: controller.state.when(
              initial: () => const SizedBox.shrink(),
              error: (message) => SupportCenterGeneralError(
                message: message,
                onPressed: controller.load,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
