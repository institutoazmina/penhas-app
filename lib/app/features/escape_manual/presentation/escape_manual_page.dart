import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
              child: Text(
                assistant.explanation,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: DesignSystemColors.darkIndigoThree,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
              child: OutlinedButton(
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
            ),
            const SizedBox(height: 16),
            ...screen.sections
                .map((section) => _SectionTasksWidget(section))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _SectionTasksWidget extends StatelessWidget {
  const _SectionTasksWidget(this.section);

  final EscapeManualTasksSectionEntity section;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      title: Text(
        section.title,
        textAlign: TextAlign.start,
      ),
      children: section.tasks.map((task) => _TaskWidget(task)).toList(),
    );
  }
}

class _TaskWidget extends StatefulWidget {
  const _TaskWidget(this.task);

  final EscapeManualTaskEntity task;

  @override
  State<_TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState
    extends ModularState<_TaskWidget, EscapeManualController> {
  EscapeManualTaskEntity get task => widget.task;

  late bool isChecked = task.isDone;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      horizontalTitleGap: 4,
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: HtmlWidget(task.description),
        value: isChecked,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: _onChanged,
      ),
    );
  }

  void _onChanged(bool? value) {
    final isDone = value ?? false;
    controller.updateTask(task.copyWith(isDone: isDone));

    setState(() {
      isChecked = isDone;
    });
  }
}
