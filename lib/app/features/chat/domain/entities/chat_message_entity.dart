import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  const ChatMessageEntity({
    required this.id,
    required this.isMe,
    required this.message,
    required this.time,
  });

  final int? id;
  final bool isMe;
  final String? message;
  final DateTime time;

  @override
  List<Object?> get props => [
        id!,
        isMe,
        message!,
        time,
      ];
}
