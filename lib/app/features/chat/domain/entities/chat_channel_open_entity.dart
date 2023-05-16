import 'package:equatable/equatable.dart';

import 'chat_channel_session_entity.dart';

class ChatChannelOpenEntity extends Equatable {
  const ChatChannelOpenEntity({
    required this.token,
    this.session,
  });

  final String? token;
  final ChatChannelSessionEntity? session;

  @override
  List<Object?> get props => [
        token,
        session,
      ];
}
