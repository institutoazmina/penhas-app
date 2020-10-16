import 'package:flutter_test/flutter_test.dart';
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
      final model = ChatChannelAvailableModel(
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
      final jsonFile = "chat/chat_list_channel.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelAvailableModel(
        hasMore: false,
        nextPage: null,
        channels: [
          ChatChannelModel(
            token: "__my_very_secret_session__",
            lastMessageTime: DateTime.parse("2020-10-04T09:20:37Z"),
            lastMessageIsMime: true,
            user: ChatUserModel(
              blockedMe: false,
              activity: "há pouco tempo",
              nickname: "Maria",
              avatar: "https://api.example.com/avatar/padrao.svg",
              userId: null,
            ),
          ),
          ChatChannelModel(
            token: "__my_very_secret_session__",
            lastMessageTime: DateTime.parse("2020-10-04T09:15:27Z"),
            lastMessageIsMime: true,
            user: ChatUserModel(
              blockedMe: false,
              activity: "há alguns dias",
              nickname: "Julia",
              avatar: "https://api.example.com/avatar/padrao.svg",
              userId: null,
            ),
          ),
        ],
        support: ChatChannelModel(
          token: "Sda24",
          lastMessageTime: DateTime.parse("2020-09-09T01:00:58Z"),
          lastMessageIsMime: true,
          user: ChatUserModel(
            blockedMe: false,
            activity: "",
            nickname: "Suporte PenhaS",
            avatar: "https://api.example.com/avatar/suporte-chat.png",
            userId: null,
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
      final jsonFile = "chat/chat_list_channel_empty.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelAvailableModel(
        hasMore: false,
        nextPage: null,
        channels: [],
        support: ChatChannelModel(
          token: "Sda24",
          lastMessageTime: DateTime.parse("2020-09-09T01:00:58Z"),
          lastMessageIsMime: true,
          user: ChatUserModel(
            blockedMe: false,
            activity: "",
            nickname: "Suporte PenhaS",
            avatar: "https://api.example.com/avatar/suporte-chat.png",
            userId: null,
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
