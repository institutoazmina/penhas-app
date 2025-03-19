import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.isMe,
    required super.message,
    required super.time,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatMessageModel(
        id: jsonData['id'],
        isMe: jsonData['is_me'] == 1,
        message: jsonData['message'],
        time: DateTime.parse(jsonData['time'] as String),
      );
}
