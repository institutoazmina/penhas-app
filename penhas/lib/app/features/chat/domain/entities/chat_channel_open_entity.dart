import 'package:equatable/equatable.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_channel_session_entity.dart';

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
