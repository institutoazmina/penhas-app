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

    List<QuizMessageEntity> _currentMessageWithPrevious() {
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
          type: QuizMessageType.displayText,
          style: "normal",
        ),
        QuizMessageEntity(
          content: "Sim",
          type: QuizMessageType.displayTextResponse,
          style: "normal",
        ),
        QuizMessageEntity(
          content:
              "Você acredita que tem uma relação saudável com o seu parceiro ou parceira?",
          type: QuizMessageType.yesno,
          ref: "YN3",
        ),
      ];
    }

    List<QuizMessageEntity> _currentMessageWithMultipleChoices() {
      return [
        QuizMessageEntity(
            content:
                "Que tal nos contar um pouco como você acha que pode ajudar outras mulheres? Suas opções ficarão visíveis para as outras usuárias",
            type: QuizMessageType.multipleChoices,
            ref: "MC7",
            options: [
              QuizMessageMultiplechoicesOptions(
                  index: '0', display: 'Escuta acolhedora'),
              QuizMessageMultiplechoicesOptions(
                  index: '1', display: 'Psicologia'),
              QuizMessageMultiplechoicesOptions(index: '2', display: 'Abrigo'),
            ]),
      ];
    }

    test('should return a valid model with only current message in JSON',
        () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final List<QuizMessageEntity> currentMessage = _currentMessage();
      final QuizSessionEntity quizSession = QuizSessionEntity(
        currentMessage: currentMessage,
        sessionId: 200,
      );
      final AppStateEntity expected = AppStateModel(quizSession);
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with previous message',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
          from: 'profile/quiz_session_response_with_previous_message.json');
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithPrevious();
      final QuizSessionEntity quizSession = QuizSessionEntity(
        currentMessage: currentMessage,
        sessionId: 247,
      );
      final AppStateEntity expected = AppStateModel(quizSession);
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });

    test('should return a valid model with JSON with multiplechoices',
        () async {
      // arrange
      final jsonData = await JsonUtil.getJson(
          from: 'profile/quiz_session_resonse_multiple_choices.json');
      final List<QuizMessageEntity> currentMessage =
          _currentMessageWithMultipleChoices();
      final QuizSessionEntity quizSession = QuizSessionEntity(
        currentMessage: currentMessage,
        sessionId: 255,
      );
      final AppStateEntity expected = AppStateModel(quizSession);
      // act
      final result = AppStateModel.fromJson(jsonData);
      // assert
      expect(result, expected);
    });
  });
}
