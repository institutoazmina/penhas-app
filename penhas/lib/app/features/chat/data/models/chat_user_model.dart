import 'package:penhas/app/features/chat/domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  ChatUserModel({
    required String activity,
    required String? nickname,
    required String? avatar,
    required int? userId,
    required bool blockedMe,
  }) : super(
          activity: activity,
          nickname: nickname,
          avatar: avatar,
          userId: userId,
          blockedMe: blockedMe,
        );

  factory ChatUserModel.fromJson(Map<String, dynamic> jsonData) =>
      ChatUserModel(
        activity: jsonData['activity'] ?? jsonData['other_activity'] ?? '',
        nickname: jsonData['apelido'] ?? jsonData['other_apelido'],
        avatar: jsonData['avatar_url'] ?? jsonData['other_avatar_url'],
        userId: jsonData['cliente_id'],
        blockedMe: jsonData['blocked_me'] == 1,
      );
}
