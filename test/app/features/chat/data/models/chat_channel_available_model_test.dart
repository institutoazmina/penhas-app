import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/data/model/quiz_session_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/chat/data/models/chat_assistant_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_available_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_user_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_available_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  setUp(() {});
  group('ChatChannelAvailableModel', () {
    test('should a subclass of ChatChannelAvailableEntity', () async {
      // act
      const model = ChatChannelAvailableModel(
        assistant: null,
        hasMore: null,
        nextPage: null,
        channels: null,
        support: null,
      );
      // assert
      expect(model, isA<ChatChannelAvailableEntity>());
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      const jsonFile = 'chat/chat_list_channel.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelAvailableModel(
        hasMore: false,
        nextPage: null,
        channels: [
          ChatChannelModel(
            token: '__my_very_secret_session__',
            lastMessageTime: DateTime.parse('2020-10-04T09:20:37Z'),
            lastMessageIsMime: true,
            user: const ChatUserModel(
                blockedMe: false,
                activity: 'há pouco tempo',
                nickname: 'Maria',
                avatar: 'https://api.example.com/avatar/padrao.svg',
                userId: null,
                badges: []),
          ),
          ChatChannelModel(
            token: '__my_very_secret_session__',
            lastMessageTime: DateTime.parse('2020-10-04T09:15:27Z'),
            lastMessageIsMime: true,
            user: const ChatUserModel(
                blockedMe: false,
                activity: 'há alguns dias',
                nickname: 'Julia',
                avatar: 'https://api.example.com/avatar/padrao.svg',
                userId: null,
                badges: []),
          ),
        ],
        support: ChatChannelModel(
          token: 'Sda24',
          lastMessageTime: DateTime.parse('2020-09-09T01:00:58Z'),
          lastMessageIsMime: true,
          user: const ChatUserModel(
              blockedMe: false,
              activity: '',
              nickname: 'Suporte PenhaS',
              avatar: 'https://api.example.com/avatar/suporte-chat.png',
              userId: null,
              badges: []),
        ),
        assistant: const ChatAssistantModel(
          avatar: null,
          title: 'Assistente PenhaS',
          subtitle: 'Entenda se você está em situação de violência',
          quizSession: QuizSessionModel(
            currentMessage: [
              QuizMessageModel(
                content: 'Deseja responder o questionário novamente?',
                type: QuizMessageType.yesno,
                ref: 'reset_questionnaire',
              ),
            ],
            sessionId: 'Ada24',
            isFinished: false,
            endScreen: null,
          ),
        ),
      );
      // act
      final matcher = ChatChannelAvailableModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
    test('should return a valid model with a valid JSON with empty channels',
        () async {
      // arrange
      const jsonFile = 'chat/chat_list_channel_empty.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelAvailableModel(
        hasMore: false,
        nextPage: null,
        channels: const [],
        support: ChatChannelModel(
          token: 'Sda24',
          lastMessageTime: DateTime.parse('2020-09-09T01:00:58Z'),
          lastMessageIsMime: true,
          user: const ChatUserModel(
              blockedMe: false,
              activity: '',
              nickname: 'Suporte PenhaS',
              avatar: 'https://api.example.com/avatar/suporte-chat.png',
              userId: null,
              badges: []),
        ),
        assistant: const ChatAssistantModel(
          avatar: null,
          title: 'Assistente PenhaS',
          subtitle: 'Entenda se você está em situação de violência',
          quizSession: QuizSessionModel(
            currentMessage: [
              QuizMessageModel(
                content: 'Deseja responder o questionário novamente?',
                type: QuizMessageType.yesno,
                ref: 'reset_questionnaire',
              ),
            ],
            sessionId: 'Ada24',
            isFinished: false,
            endScreen: null,
          ),
        ),
      );
      // act
      final matcher = ChatChannelAvailableModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
