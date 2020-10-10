import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_open_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_user_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_open_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  setUp(() {});

  group('ChatChannelOpenModel', () {
    test('should a subclass of ChatChannelOpenEntity', () async {
      // act
      final model = ChatChannelOpenModel(session: null, token: null);
      // assert
      expect(model, isA<ChatChannelOpenEntity>());
    });
    test('should should return a valid model from a valid JSON', () async {
      // arrange
      final jsonFile = "chat/chat_open_channel.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelOpenModel(
        token: "__my_very_secret_session__",
        session: ChatChannelSessionModel(
          hasMore: false,
          newer: "__my_pagination__",
          older: null,
          messages: [],
          metadata: ChatChannelSessionMetadataModel(
            canSendMessage: true,
            didBlocked: false,
            headerMessage: "",
            headerWarning: "",
            isBlockable: true,
            lastMessageEtag: "482b55",
          ),
          user: ChatUserModel(
            activity: "há poucos dias",
            nickname: "Maria",
            avatar: "https://api.example.com/avatar/padrao.svg",
            userId: 180,
          ),
        ),
      );
      // act
      final matcher = ChatChannelOpenModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
