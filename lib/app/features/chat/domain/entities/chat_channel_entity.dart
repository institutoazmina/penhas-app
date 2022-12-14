import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatChannelEntity extends Equatable {
  const ChatChannelEntity({
    required this.token,
    required this.lastMessageTime,
    required this.lastMessageIsMime,
    required this.user,
  });

  final String? token;
  final DateTime? lastMessageTime;
  final bool? lastMessageIsMime;
  final ChatUserEntity user;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        token!,
        lastMessageTime!,
        lastMessageIsMime!,
        user,
      ];
}
