import '../../domain/entities/chat_badge_entity.dart';
import '../../domain/entities/chat_user_entity.dart';

class ChatUserModel extends ChatUserEntity {
  const ChatUserModel({
    required String super.activity,
    required super.nickname,
    required super.avatar,
    required super.userId,
    required super.blockedMe,
    required super.badges,
  });

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
      {required super.code,
      required super.description,
      required super.imageUrl,
      required super.imageUrlBlack,
      required super.name,
      required super.style,
      required super.showDescription,
      required super.popUp});

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
