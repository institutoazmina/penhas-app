import 'package:flutter/material.dart';

import '../../../../appstate/domain/entities/app_state_entity.dart';
import '../quiz_typedef.dart';
import 'quiz_button_yes_no_widget.dart';
import 'quiz_horizontal_buttons.dart';
import 'quiz_multiple_choices_widget.dart';
import 'quiz_show_help_tutorial_widget.dart';
import 'quiz_show_stealth_tutorial_widget.dart';
import 'quiz_single_button.dart';
import 'quiz_single_choice_widget.dart';

class QuizUserReplyWidget extends StatelessWidget {
  const QuizUserReplyWidget({
    Key? key,
    required QuizMessageEntity? message,
    required this.onActionReply,
  })  : _message = message,
        super(key: key);

  final QuizMessageEntity? _message;
  final UserReaction onActionReply;

  QuizMessageType? get type => _message?.type;
  QuizMessageEntity get message => _message!;

  @override
  Widget build(BuildContext context) {
    final type = this.type;
    if (type == null) return const SizedBox.shrink();

    switch (type) {
      case QuizMessageType.yesno:
        return QuizButtonYesNoWidget(
          reference: message.ref,
          onPressed: onActionReply,
        );
      case QuizMessageType.horizontalButtons:
        return QuizHorizontalButtonsWidget(
          reference: message.ref,
          options: message.options!,
          onPressed: onActionReply,
        );
      case QuizMessageType.showHelpTutorial:
        return QuizShowHelpTutorialWidget(
          reference: message.ref,
          onPressed: onActionReply,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.showStealthTutorial:
        return QuizShowStealthTutorialWidget(
          reference: message.ref,
          onPressed: onActionReply,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.button:
        return QuizSingleButtonWidget(
          reference: message.ref,
          onPressed: onActionReply,
          buttonLabel: message.buttonLabel,
        );
      case QuizMessageType.multipleChoices:
        return QuizMultipleChoicesWidget(
          reference: message.ref,
          options: message.options,
          onPressed: onActionReply,
        );
      case QuizMessageType.singleChoice:
        return QuizSingleChoiceWidget(
          reference: message.ref,
          options: message.options!,
          onPressed: onActionReply,
        );
      case QuizMessageType.forceReload:
      case QuizMessageType.displayText:
      case QuizMessageType.displayTextResponse:
        return Container();
    }
  }
}
