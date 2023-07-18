import 'package:flutter/material.dart';

import '../../../appstate/domain/entities/app_state_entity.dart';
import 'quiz_button_yes_no_widget.dart';
import 'quiz_multiple_choices_widget.dart';
import 'quiz_show_help_tutorial_widget.dart';
import 'quiz_show_stealth_tutorial_widget.dart';
import 'quiz_single_button.dart';
import 'quiz_single_choice_widget.dart';
import 'quiz_typedef.dart';

class QuizUserReplayWidget extends StatelessWidget {
  const QuizUserReplayWidget({
    Key? key,
    required this.message,
    required this.onActionReplay,
  }) : super(key: key);

  final QuizMessageEntity message;
  final UserReaction onActionReplay;

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case QuizMessageType.yesno:
        return QuiZButtonYesNoWidget(
          reference: message.ref,
          onPressed: onActionReplay,
        );
      case QuizMessageType.showHelpTutorial:
        return QuizShowHelpTutorialWidget(
          reference: message.ref,
          onPressed: onActionReplay,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.showStealthTutorial:
        return QuizShowStealthTutorialWidget(
          reference: message.ref,
          onPressed: onActionReplay,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.button:
        return QuizSingleButtonWidget(
          reference: message.ref,
          onPressed: onActionReplay,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.multipleChoices:
        return QuizMultipleChoicesWidget(
          reference: message.ref,
          options: message.options,
          onPressed: onActionReplay,
        );
      case QuizMessageType.singleChoice:
        return QuizSingleChoiceWidget(
          reference: message.ref,
          options: message.options!,
          onPressed: onActionReplay,
        );
      case QuizMessageType.forceReload:
      case QuizMessageType.displayText:
      case QuizMessageType.displayTextResponse:
        return Container();
    }
  }
}
