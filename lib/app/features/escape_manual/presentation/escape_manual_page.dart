import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/design_system/button_shape.dart';
import '../../../shared/design_system/colors.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../../support_center/presentation/pages/support_center_general_error.dart';
import '../domain/entity/escape_manual.dart';
import 'escape_manual_controller.dart';
import 'escape_manual_state.dart';

typedef OpenAssistantPressed = void Function(
  EscapeManualAssistantActionEntity action,
);

class EscapeManualPage extends StatefulWidget {
  const EscapeManualPage({Key? key}) : super(key: key);

  @override
  State<EscapeManualPage> createState() => _EscapeManualPageState();
}

class _EscapeManualPageState
    extends ModularState<EscapeManualPage, EscapeManualController>
    with SnackBarHandler {
  ReactionDisposer? _disposer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposer ??= controller.onReaction(_onReaction);
    controller.load();
  }

  @override
  void dispose() {
    _disposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Observer(
        builder: (_) => PageProgressIndicator(
          progressMessage: 'Carregando...',
          progressState: controller.progressState,
          child: controller.state.when(
            initial: () => _InitialStateWidget(),
            loaded: (screen) => _LoadedStateWidget(
              screen: screen,
              openAssistantPressed: controller.openAssistant,
            ),
            error: (message) => _ErrorStateWidget(
              message: message,
              onRetryPressed: controller.load,
            ),
          ),
        ),
      ),
    );
  }

  void _onReaction(EscapeManualReaction? reaction) {
    Modular.debugPrintModular('coisou: $reaction');
    reaction?.when(
      showSnackbar: (message) => showSnackBar(
        scaffoldKey: _scaffoldKey,
        message: message,
      ),
    );
  }
}

class _InitialStateWidget extends Container {
  _InitialStateWidget()
      : super(color: DesignSystemColors.systemBackgroundColor);
}

class _ErrorStateWidget extends SupportCenterGeneralError {
  const _ErrorStateWidget({
    required String message,
    required VoidCallback onRetryPressed,
  }) : super(message: message, onPressed: onRetryPressed);
}

class _LoadedStateWidget extends StatelessWidget {
  const _LoadedStateWidget({
    required this.screen,
    required this.openAssistantPressed,
  });

  final EscapeManualEntity screen;
  final OpenAssistantPressed openAssistantPressed;

  @override
  Widget build(BuildContext context) {
    final assistant = screen.assistant;

    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
        child: Column(
          children: [
            Text(
              assistant.explanation,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: DesignSystemColors.darkIndigoThree,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                openAssistantPressed(assistant.action);
              },
              child: Text(assistant.action.text),
              style: OutlinedButton.styleFrom(
                primary: DesignSystemColors.darkIndigoThree,
                backgroundColor: DesignSystemColors.white,
                textStyle: textTheme.button?.copyWith(
                  fontSize: 18,
                ),
                minimumSize: const Size(double.infinity, 50),
                shape: kButtonShapeOutlineWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
