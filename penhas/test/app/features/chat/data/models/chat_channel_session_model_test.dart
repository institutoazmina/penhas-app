import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/chat/data/models/chat_channel_session_model.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';

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
  });
}
