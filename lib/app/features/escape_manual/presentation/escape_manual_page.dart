import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    controller.dispose();
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
            loaded: (data) => _LoadedStateWidget(
              escapeManual: data,
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
      showSnackBar: (message) => showSnackBar(
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
    required this.escapeManual,
    required this.openAssistantPressed,
  });

  final EscapeManualEntity escapeManual;
  final OpenAssistantPressed openAssistantPressed;

  @override
  Widget build(BuildContext context) {
    final assistant = escapeManual.assistant;
    final sections = escapeManual.sections.toList();
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const _Divider(),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];
              return _SectionTasksWidget(section);
            },
            separatorBuilder: (context, index) => const _Divider(),
          ),
          const _Divider(),
        ],
      ),
    );
  }
}

class _SectionTasksWidget extends StatelessWidget {
  const _SectionTasksWidget(this.section);

  final EscapeManualTasksSectionEntity section;

  @override
  Widget build(BuildContext context) {
    final qtyDoneTasks = section.tasks.where((task) => task.isDone).length;

    return ExpansionTile(
      childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            section.title,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: DesignSystemColors.darkIndigoThree,
                ),
          ),
          Text(
            '$qtyDoneTasks/${section.tasks.length}',
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: DesignSystemColors.brownishGrey,
                ),
          ),
        ],
      ),
      children: [
        const _Divider(),
        ...section.tasks.map(
          (task) => _TaskWidget(
            task,
            key: Key('escape-manual-task-${task.id}'),
          ),
        ),
      ].toList(),
    );
  }
}

class _TaskWidget extends StatefulWidget {
  const _TaskWidget(this.task, {Key? key}) : super(key: key);

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
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        checkboxTheme: theme.checkboxTheme.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(
            color: Color.fromRGBO(216, 216, 216, 1),
            width: 2,
          ),
        ),
      ),
      child: ListTileTheme(
        horizontalTitleGap: 4,
        child: Opacity(
          opacity: task.isDone ? 0.5 : 1,
          child: CheckboxListTile(
            contentPadding: const EdgeInsets.all(8),
            title: HtmlWidget(
              task.description,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: DesignSystemColors.darkIndigoThree,
                  ),
            ),
            value: isChecked,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: _onChanged,
            secondary: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: DesignSystemColors.darkIndigoThree,
              ),
              offset: const Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (context) => [
                _TaskActionWidget(
                  text: 'Apagar',
                  icon: 'assets/images/svg/actions/delete.svg',
                  size: theme.iconTheme.size,
                  onTap: () => controller.deleteTask(task),
                ),
              ],
            ),
          ),
        ),
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

class _TaskActionWidget extends PopupMenuItem {
  _TaskActionWidget({
    required String icon,
    required String text,
    required VoidCallback onTap,
    double? size,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                color: DesignSystemColors.darkIndigoThree,
                height: size,
                width: size,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: DesignSystemColors.darkIndigoThree,
                ),
              ),
            ],
          ),
          onTap: onTap,
        );
}

class _Divider extends Divider {
  const _Divider() : super(height: 1, color: DesignSystemColors.blueyGrey);
}
