import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  final int id;
  final bool isMe;
  final String message;
  final DateTime time;

  ChatMessageModel({
    @required this.id,
    @required this.isMe,
    @required this.message,
    @required this.time,
  }) : super(
          id: id,
          isMe: isMe,
          message: message,
          time: time,
        );

  ChatMessageModel.fromJson(Map<String, Object> jsonData)
      : id = jsonData["id"],
        isMe = jsonData["is_me"] == 1,
        message = jsonData["message"],
        time = DateTime.parse(jsonData["time"]);
}
