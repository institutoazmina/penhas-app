import 'package:equatable/equatable.dart';

class ChatUserEntity extends Equatable {
  final String? activity;
  final String? nickname;
  final String? avatar;
  final int? userId;
  final bool blockedMe;

  ChatUserEntity({
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
  bool get stringify => true;

  @override
  List<Object?> get props => [
        activity!,
        nickname!,
        avatar!,
        userId!,
        blockedMe,
      ];
}
