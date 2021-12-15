import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final int? id;
  final bool isMe;
  final String? message;
  final DateTime time;

  const ChatMessageEntity({
    required this.id,
    required this.isMe,
    required this.message,
    required this.time,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id!,
        isMe,
        message!,
        time,
      ];
}
