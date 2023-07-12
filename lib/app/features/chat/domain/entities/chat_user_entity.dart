import 'package:equatable/equatable.dart';

class ChatUserEntity extends Equatable {
  const ChatUserEntity({
    required this.activity,
    required this.nickname,
    required this.avatar,
    required this.userId,
    required this.blockedMe,
  });

  factory ChatUserEntity.empty() => const ChatUserEntity(
        userId: -1,
        activity: null,
        avatar: null,
        nickname: null,
        blockedMe: false,
      );

  final String? activity;
  final String? nickname;
  final String? avatar;
  final int? userId;
  final bool blockedMe;

  @override
  List<Object?> get props => [
        activity,
        nickname,
        avatar,
        userId,
        blockedMe,
      ];
}
