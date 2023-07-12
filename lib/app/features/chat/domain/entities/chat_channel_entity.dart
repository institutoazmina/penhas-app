import 'package:equatable/equatable.dart';

import 'chat_user_entity.dart';

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
  List<Object?> get props => [
        token!,
        lastMessageTime!,
        lastMessageIsMime!,
        user,
      ];
}
