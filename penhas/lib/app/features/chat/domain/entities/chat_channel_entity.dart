import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'chat_user_entity.dart';

class ChatChannelEntity extends Equatable {
  final String token;
  final DateTime lastMessageTime;
  final bool lastMessageIsMime;
  final ChatUserEntity user;

  ChatChannelEntity({
    @required this.token,
    @required this.lastMessageTime,
    @required this.lastMessageIsMime,
    @required this.user,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        token,
        lastMessageTime,
        lastMessageIsMime,
        user,
      ];
}
