import '../../domain/entities/chat_badge_entity.dart';
import '../../domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  const ChatUserModel({
    required String activity,
    required String? nickname,
    required String? avatar,
    required int? userId,
    required bool blockedMe,
    required List<ChatBadgeEntity> badges,
  }) : super(
          activity: activity,
          nickname: nickname,
          avatar: avatar,
          userId: userId,
          blockedMe: blockedMe,
          badges: badges,
        );

  factory ChatUserModel.fromJson(Map<String, dynamic> jsonData) {
    List<ChatBadgeEntity> badges = [];
    if (jsonData['other_badges'] != null) {
      badges = _parseBadges(jsonData['other_badges']);
    }

    return ChatUserModel(
      activity: jsonData['activity'] ?? jsonData['other_activity'] ?? '',
      nickname: jsonData['apelido'] ?? jsonData['other_apelido'],
      avatar: jsonData['avatar_url'] ?? jsonData['other_avatar_url'],
      userId: jsonData['cliente_id'],
      blockedMe: jsonData['blocked_me'] == 1,
      badges: badges,
    );
  }

  static List<ChatBadgeEntity> _parseBadges(List<dynamic> badges) {
    return badges.map((e) => ChatBadgeModel.fromJson(e)).toList();
  }
}

class ChatBadgeModel extends ChatBadgeEntity {
  ChatBadgeModel(
      {required String code,
      required String description,
      required String imageUrl,
      required String imageUrlBlack,
      required String name,
      required String style,
      required int showDescription,
      required int popUp})
      : super(
            code: code,
            description: description,
            imageUrl: imageUrl,
            imageUrlBlack: imageUrlBlack,
            name: name,
            style: style,
            showDescription: showDescription,
            popUp: popUp);

  factory ChatBadgeModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatBadgeModel(
        code: jsonData['code'],
        description: jsonData['description'],
        imageUrl: jsonData['image_url'],
        imageUrlBlack: jsonData['image_url_black'],
        name: jsonData['name'],
        style: jsonData['style'],
        showDescription: jsonData['show_description'],
        popUp: jsonData['popup']);
  }
}
