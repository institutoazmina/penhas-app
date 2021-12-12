import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';
=======

import 'chat_user_entity.dart';
>>>>>>> Fix code syntax

class ChatChannelEntity extends Equatable {
  final String? token;
  final DateTime? lastMessageTime;
  final bool? lastMessageIsMime;
  final ChatUserEntity user;

  ChatChannelEntity({
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
  List<Object> get props => [
        token!,
        lastMessageTime!,
        lastMessageIsMime!,
        user,
      ];
}
