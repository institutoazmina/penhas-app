import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  final String activity;
  final String? nickname;
  final String? avatar;
  final int? userId;
  final bool blockedMe;

  ChatUserModel({
    required this.activity,
    required this.nickname,
    required this.avatar,
    required this.userId,
    required this.blockedMe,
  }) : super(
          activity: activity,
          nickname: nickname,
          avatar: avatar,
          userId: userId,
          blockedMe: blockedMe,
        );

  ChatUserModel.fromJson(Map<String, Object> jsonData)
      : activity = jsonData["activity"] as String? ?? jsonData["other_activity"] as String? ?? "",
        nickname = jsonData["apelido"] as String? ?? jsonData["other_apelido"] as String?,
        avatar = jsonData["avatar_url"] as String? ?? jsonData["other_avatar_url"] as String?,
        userId = jsonData["cliente_id"] as int?,
        blockedMe = jsonData["blocked_me"] == 1;
}
