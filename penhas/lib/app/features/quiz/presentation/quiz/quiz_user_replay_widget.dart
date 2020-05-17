import 'package:flutter/material.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/button_yes_no_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';

class QuizUserReplayWidget extends StatelessWidget {
  final QuizMessageEntity message;
  final UserReaction onActionReplay;

  const QuizUserReplayWidget({
    Key key,
    @required this.message,
    @required this.onActionReplay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case QuizMessageType.yesno:
        return ButtonYesNoWidget(
          reference: message.ref,
          onPressed: onActionReplay,
        );
      case QuizMessageType.multipleChoices:
        throw UnimplementedError();
      case QuizMessageType.button:
        throw UnimplementedError();
      case QuizMessageType.from:
      case QuizMessageType.displayText:
        return Container();
    }

    return Container();
  }
}
