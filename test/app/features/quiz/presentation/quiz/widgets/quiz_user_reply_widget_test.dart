import 'package:flutter/widgets.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_button_yes_no_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_horizontal_buttons.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_multiple_choices_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_show_help_tutorial_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_show_stealth_tutorial_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_single_button.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_single_choice_widget.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/widgets/quiz_user_reply_widget.dart';

void main() {
  final widgetTypes = {
    QuizMessageType.yesno: QuizButtonYesNoWidget,
    QuizMessageType.horizontalButtons: QuizHorizontalButtonsWidget,
    QuizMessageType.showHelpTutorial: QuizShowHelpTutorialWidget,
    QuizMessageType.showStealthTutorial: QuizShowStealthTutorialWidget,
    QuizMessageType.button: QuizSingleButtonWidget,
    QuizMessageType.multipleChoices: QuizMultipleChoicesWidget,
    QuizMessageType.singleChoice: QuizSingleChoiceWidget,
    QuizMessageType.forceReload: Container,
    QuizMessageType.displayText: Container,
    QuizMessageType.displayTextResponse: Container,
  };

  group(QuizUserReplyWidget, () {
    for (final messageType in QuizMessageType.values) {
      final widgetType = widgetTypes[messageType];

      test(
        'widget type is not null when message type is $messageType',
        () {
          // assert
          expect(widgetType, isNotNull);
        },
      );

      testWidgets(
        'should render $widgetType when type is $messageType',
        (tester) async {
          // act
          await tester.pumpWidget(
            buildTestableWidget(
              QuizUserReplyWidget(
                message: QuizMessageEntity(
                  type: messageType,
                  content: 'content',
                  ref: 'message ref',
                  buttonLabel: 'button label',
                  options: const [],
                ),
                onActionReply: (_) {},
              ),
            ),
          );

          // assert
          expect(find.byType(widgetType!), findsOneWidget);
        },
        skip: widgetType == null,
      );
    }
  });
}
