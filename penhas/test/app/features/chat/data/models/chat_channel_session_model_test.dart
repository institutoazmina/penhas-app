import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/data/models/chat_user_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  setUp(() {});

  group('ChatChannelSessionModel', () {
    test('should a subclass of ChatChannelSessionEntity', () async {
      // act
      final model = ChatChannelSessionModel(
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

    test('should return a valid model with a valid JSON with empty channels',
        () async {
      // arrange
      final jsonFile = "chat/chat_read_channel_empty.json";
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = ChatChannelSessionModel(
          hasMore: false,
          newer: null,
          older: null,
          messages: [],
          metadata: ChatChannelSessionMetadataModel(
            canSendMessage: true,
            didBlocked: false,
            headerMessage: "",
            headerWarning: "",
            isBlockable: true,
            lastMessageEtag: "4df2ae",
          ),
          user: ChatUserModel(
            activity: "há pouco tempo",
            nickname: "Julia",
            avatar: "https://api.example.com/avatar/padrao.svg",
            userId: 3191,
          ));
      // act
      final matcher = ChatChannelSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
