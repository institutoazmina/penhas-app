import 'package:flutter/material.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import 'package:penhas/app/features/quiz/presentation/quiz/quiz_button_yes_no_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_multiple_choices_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_show_help_tutorial_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_show_stealth_tutorial_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_single_button.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';

class QuizUserReplayWidget extends StatelessWidget {
  final QuizMessageEntity? message;
  final UserReaction onActionReplay;

  const QuizUserReplayWidget({
    required Key key,
    required this.message,
    required this.onActionReplay,
  }) : super(key: key);

  final QuizMessageEntity message;
  final UserReaction onActionReplay;

  @override
  Widget build(BuildContext context) {
    switch (message!.type) {
      case QuizMessageType.yesno:
        return QuiZButtonYesNoWidget(
          reference: message!.ref,
          onPressed: onActionReplay,
        );
      case QuizMessageType.showHelpTutorial:
        return QuizShowHelpTutorialWidget(
          reference: message!.ref,
          onPressed: onActionReplay,
          buttonLabel: message!.buttonLabel,
        );
      case QuizMessageType.showStealthTutorial:
        return QuizShowStealthTutorialWidget(
          reference: message!.ref,
          onPressed: onActionReplay,
          buttonLabel: message!.buttonLabel,
        );
      case QuizMessageType.button:
        return QuizSingleButtonWidget(
          reference: message!.ref,
          onPressed: onActionReplay,
          buttonLabel: message!.buttonLabel,
        );
      case QuizMessageType.multipleChoices:
        return QuizMultipleChoicesWidget(
          reference: message!.ref,
          options: message!.options,
          onPressed: onActionReplay,
        );
      case QuizMessageType.from:
      case QuizMessageType.forceReload:
      case QuizMessageType.displayText:
      case QuizMessageType.displayTextResponse:
        return Container();
    }
  }
}
