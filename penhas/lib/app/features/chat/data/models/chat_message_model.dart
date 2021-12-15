import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required int? id,
    required bool isMe,
    required String? message,
    required DateTime time,
  }) : super(
          id: id,
          isMe: isMe,
          message: message,
          time: time,
        );

  factory ChatMessageModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatMessageModel(
        id: jsonData['id'],
        isMe: jsonData['is_me'] == 1,
        message: jsonData['message'],
        time: DateTime.parse(jsonData['time'] as String),
      );
}
