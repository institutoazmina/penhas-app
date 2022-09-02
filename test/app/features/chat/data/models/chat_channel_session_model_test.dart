import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_message_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_user_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  setUp(() {});

  group('ChatChannelSessionModel', () {
    test('should a subclass of ChatChannelSessionEntity', () async {
      // act
      const model = ChatChannelSessionModel(
        hasMore: null,
        newer: null,
        older: null,
        messages: null,
        metadata: null,
        user: null,
      );
      // assert
      expect(model, isA<ChatChannelSessionEntity>());
    });

    test('should return a valid model from valid JSON with empty messages',
        () async {
      // arrange
      const jsonFile = 'chat/chat_read_channel_empty.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      const actual = ChatChannelSessionModel(
          hasMore: false,
          newer: null,
          older: null,
          messages: [],
          metadata: ChatChannelSessionMetadataModel(
            canSendMessage: true,
            didBlocked: false,
            headerMessage: '',
            headerWarning: '',
            isBlockable: true,
            lastMessageEtag: '4df2ae',
          ),
          user: ChatUserModel(
            blockedMe: false,
            activity: 'há pouco tempo',
            nickname: 'Julia',
            avatar: 'https://api.example.com/avatar/padrao.svg',
            userId: 3191,
          ),);
      // act
      final matcher = ChatChannelSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      const jsonFile = 'chat/chat_read_channel.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelSessionModel(
          hasMore: false,
          newer: '--my-pagination-token--',
          older: '--my-older-pagination-token--',
          messages: [
            ChatMessageModel(
              id: 172,
              isMe: true,
              message: 'Ola mundo!',
              time: DateTime.parse('2020-10-04T09:30:54Z'),
            )
          ],
          metadata: const ChatChannelSessionMetadataModel(
            canSendMessage: true,
            didBlocked: false,
            headerMessage: 'Minha mensagem',
            headerWarning: 'Meu alerta',
            isBlockable: true,
            lastMessageEtag: '4a295f',
          ),
          user: const ChatUserModel(
            blockedMe: false,
            activity: 'há pouco tempo',
            nickname: 'Julia',
            avatar: 'https://api.example.com/avatar/padrao.svg',
            userId: 3191,
          ),);
      // act
      final matcher = ChatChannelSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
