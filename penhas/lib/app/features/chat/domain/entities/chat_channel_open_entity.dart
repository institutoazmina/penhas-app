import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';
=======

import 'chat_channel_session_entity.dart';
>>>>>>> Fix code syntax

class ChatChannelOpenEntity extends Equatable {
  final String? token;
  final ChatChannelSessionEntity? session;

  ChatChannelOpenEntity({
    required this.token,
    this.session,
  });

  final String? token;
  final ChatChannelSessionEntity? session;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        token!,
        session!,
      ];
}
