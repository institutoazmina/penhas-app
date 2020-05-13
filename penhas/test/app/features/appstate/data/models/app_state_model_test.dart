import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/data/model/app_state_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  AppStateModel appStateModel;
  setUp(() {});

  group('AppStateModel', () {
    test('should be a subclass of AppStateEntity', () async {
      // arrange
      final session = QuizSessionEntity(
        currentMessage: [],
        previousMessage: [],
        sessionId: 1,
      );
      // act
      appStateModel = AppStateModel(session);
      // assert
      expect(appStateModel, isA<AppStateEntity>());
    });

    List<QuizMessageEntity> _currentMessage() {
      return [
        QuizMessageEntity(
          content:
              "Olá, eu sou a Assistente PenhaS ☺️ e vou te ajudar a conhecer o aplicativo 🤳",
          type: QuizMessageType.displayText,
          style: "normal",
        ),
        QuizMessageEntity(
          content:
              "Vou começar com algumas perguntas, para saber melhor como te ajudar",
          type: QuizMessageType.displayText,
          style: "normal",
        ),
        QuizMessageEntity(
          content: "Atualmente, você está em um relacionamento amoroso?",
          type: QuizMessageType.yesno,
          ref: "YN1",
        ),
      ];
    }

    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final List<QuizMessageEntity> currentMessage = _currentMessage();
      final QuizSessionEntity quizSession = QuizSessionEntity(
        currentMessage: currentMessage,
        previousMessage: null,
        sessionId: 200,
      );
      final AppStateEntity expected = AppStateModel(quizSession);
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });
  });
}
