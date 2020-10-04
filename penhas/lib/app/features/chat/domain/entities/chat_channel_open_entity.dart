import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_channel_session_entity.dart';

class ChatChannelOpenEntity extends Equatable {
  final String token;
  final ChatChannelSessionEntity session;

  ChatChannelOpenEntity({
    @required this.token,
    @required this.session,
  });
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        token,
        session,
      ];
}
