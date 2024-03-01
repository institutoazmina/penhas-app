import 'package:penhas/app/features/quiz/domain/entities/answer.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';

final quizFixture = Quiz(
  id: '42',
  redirectTo: '/mainboard',
  messages: [
    QuizMessage.text(
      reference: 'BT',
      content: 'Click on the button to continue',
    ),
    QuizMessage.button(reference: 'BT', label: 'OK', value: '1'),
    QuizMessage.text(reference: 'BTTC', content: 'Tutorial button'),
    QuizMessage.horizontalButtons(
      reference: 'BTTC',
      buttons: [
        ButtonOption(
          label: 'View tutorial',
          value: '1',
          action: ButtonAction.navigate(
            route: '/quiz/tutorial/stealth',
            readableResult: 'Tutorial visto',
          ),
        ),
      ],
    ),
    QuizMessage.text(reference: 'BTTS', content: 'Tutorial button'),
    QuizMessage.button(
      reference: 'BTTS',
      label: 'View tutorial',
      value: '1',
      action: ButtonAction.navigate(
        route: '/quiz/tutorial/help-center',
        readableResult: 'Tutorial visto',
      ),
    ),
    QuizMessage.button(
      reference: 'ST',
      label: 'View tutorial',
      value: '1',
      action: ButtonAction.navigate(
        route: '/quiz/tutorial/stealth',
        readableResult: 'Tutorial visto',
      ),
    ),
    QuizMessage.text(reference: 'YN', content: 'Do you like this quiz?'),
    QuizMessage.horizontalButtons(
      reference: 'YN',
      buttons: [
        ButtonOption(label: 'Sim', value: 'Y'),
        ButtonOption(label: 'Não', value: 'N'),
      ],
    ),
    QuizMessage.text(reference: 'YNM', content: 'Yes, no or maybe?'),
    QuizMessage.horizontalButtons(
      reference: 'YNM',
      buttons: [
        ButtonOption(label: 'Sim', value: 'Y'),
        ButtonOption(label: 'Não', value: 'N'),
        ButtonOption(label: 'Talvez', value: 'M')
      ],
    ),
    QuizMessage.text(reference: 'HBTN', content: 'Click on one of the buttons'),
    QuizMessage.horizontalButtons(
      reference: 'HBTN',
      buttons: [
        ButtonOption(label: 'First option', value: '0'),
        ButtonOption(label: 'Second option', value: '1'),
        ButtonOption(label: 'Third option', value: '2'),
      ],
    ),
    QuizMessage.text(content: 'This is a text message'),
    QuizMessage.text(content: 'This is a error message'),
    QuizMessage.text(reference: 'BTR', content: 'Try again later'),
    QuizMessage.sent(content: 'Sim', status: AnswerStatus.sent),
    QuizMessage.text(
      reference: 'MC',
      content: 'You can select multiple options',
    ),
    QuizMessage.multipleChoices(
      reference: 'MC',
      options: [
        MessageOption(label: 'First option', value: '0'),
        MessageOption(label: 'Second option', value: '1'),
        MessageOption(label: 'Third option', value: '2'),
      ],
    ),
    QuizMessage.text(
      reference: 'OC',
      content: 'You can only select one option',
    ),
    QuizMessage.singleChoice(
      reference: 'OC',
      options: [
        MessageOption(label: 'First option', value: '0'),
        MessageOption(label: 'Second option', value: '1'),
        MessageOption(label: 'Third option', value: '2'),
      ],
    ),
    QuizMessage.text(
      reference: 'SC',
      content: 'You can only select one option',
    ),
    QuizMessage.singleChoice(
      reference: 'SC',
      options: [
        MessageOption(label: 'First option', value: '0'),
        MessageOption(label: 'Second option', value: '1'),
        MessageOption(label: 'Third option', value: '2'),
      ],
    ),
  ],
);
