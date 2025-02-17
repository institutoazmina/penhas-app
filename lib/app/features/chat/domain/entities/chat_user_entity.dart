import 'package:equatable/equatable.dart';

import 'chat_badge_entity.dart';

class ChatUserEntity extends Equatable {
  const ChatUserEntity({
    required this.activity,
    required this.nickname,
    required this.avatar,
    required this.userId,
    required this.blockedMe,
    required this.badges,
  });

  factory ChatUserEntity.empty() => const ChatUserEntity(
        userId: -1,
        activity: null,
        avatar: null,
        nickname: null,
        blockedMe: false,
        badges: [],
      );

  final String? activity;
  final String? nickname;
  final String? avatar;
  final int? userId;
  final bool blockedMe;
  final List<ChatBadgeEntity> badges;

  @override
  List<Object?> get props => [
        activity,
        nickname,
        avatar,
        userId,
        blockedMe,
      ];
}
