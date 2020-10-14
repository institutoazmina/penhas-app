import 'package:meta/meta.dart';
import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  final String activity;
  final String nickname;
  final String avatar;
  final int userId;
  final bool blockedMe;

  ChatUserModel({
    @required this.activity,
    @required this.nickname,
    @required this.avatar,
    @required this.userId,
    @required this.blockedMe,
  }) : super(
          activity: activity,
          nickname: nickname,
          avatar: avatar,
          userId: userId,
          blockedMe: blockedMe,
        );

  ChatUserModel.fromJson(Map<String, Object> jsonData)
      : activity = jsonData["activity"] ?? jsonData["other_activity"] ?? "",
        nickname = jsonData["apelido"] ?? jsonData["other_apelido"],
        avatar = jsonData["avatar_url"] ?? jsonData["other_avatar_url"],
        userId = jsonData["cliente_id"],
        blockedMe = jsonData["blocked_me"] == 1;
}
