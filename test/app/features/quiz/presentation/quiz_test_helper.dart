import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/domain/entities/quiz_message.dart';
import 'package:penhas/app/features/quiz/presentation/new_quiz/quiz_page.dart';

import '../../../../utils/golden_tests.dart';

typedef ScopedBody = void Function(QuizMessageTestScope scope);

@isTestGroup
void quizMessageTestGroup(
  Object description,
  QuizMessageEntity message,
  ScopedBody body, {
  bool skip = false,
}) {
  group(
    description,
    () {
      setUp(() {
        mockQuizArgs([message]);
      });

      body(QuizMessageTestScope(message));
    },
    skip: skip,
  );
}

class QuizMessageTestScope {
  QuizMessageTestScope(this.message);

  final QuizMessageEntity message;

  @isTest
  FutureOr<void> screenshotReceived(
    String description, {
    bool skip = false,
  }) {
    screenshotTest(
      description,
      fileName: 'quiz_${message.type.name}_received',
      pageBuilder: () => NewQuizPage(),
      skip: skip,
    );
  }

  @isTest
  FutureOr<void> screenshotReplyed(
    String description,
    PumpAction action, {
    bool skip = false,
  }) {
    screenshotTest(
      description,
      fileName: 'quiz_${message.type.name}_replyed',
      pageBuilder: () => NewQuizPage(),
      pumpBeforeTest: action,
      skip: skip,
    );
  }
}

void mockQuizArgs([
  List<QuizMessageEntity> messages = const [],
  String sessionId = 'session_id',
]) {
  assert(Modular.navigatorDelegate is Mock,
      'Modular.navigatorDelegate should be a Mock');

  when(() => Modular.navigatorDelegate!.args).thenReturn(
    ModularArguments(
      data: QuizSessionEntity(sessionId: sessionId, currentMessage: messages),
    ),
  );
}

List<QuizMessageChoiceOption> createOptions(List<String> indexes) {
  return indexes
      .map(
        (index) => QuizMessageChoiceOption(
          display: 'Option $index',
          index: index,
        ),
      )
      .toList();
}

List<QuizMessage> createTextMessages({int count = 1}) {
  return List.generate(
    count,
    (index) => QuizMessage.text(content: 'message $index'),
  );
}

class QuizOkButton extends QuizMessageEntity {
  QuizOkButton()
      : super(
          type: QuizMessageType.button,
          ref: 'REF',
          content: 'please click the button',
          buttonLabel: 'OK',
        );
}
