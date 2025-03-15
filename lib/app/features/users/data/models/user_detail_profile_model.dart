import '../../domain/entities/user_detail_badge_entity.dart';
import '../../domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  const UserDetailProfileModel({
    super.nickname,
    super.avatar,
    super.clientId,
    super.miniBio,
    super.skills,
    super.activity,
    super.badges = const [],
  });

  factory UserDetailProfileModel.fromJson(Map<String, dynamic> jsonData) {
    List<UserDetailBadgeEntity> badges = [];

    if (jsonData['badges'] != null) {
      badges = _parseBadges(jsonData['badges']);
    }
    return UserDetailProfileModel(
      nickname: jsonData['apelido'],
      avatar: jsonData['avatar_url'],
      clientId: jsonData['cliente_id'],
      skills: jsonData['skills'],
      activity: jsonData['activity'],
      miniBio: jsonData['minibio'],
      badges: badges,
    );
  }

  static List<UserDetailBadgeEntity> _parseBadges(List<dynamic> badges) {
    return badges.map((e) => UserDetailBadgeModel.fromJson(e)).toList();
  }
}

class UserDetailBadgeModel extends UserDetailBadgeEntity {
  UserDetailBadgeModel(
      {required super.code,
      required super.description,
      required super.imageUrl,
      required super.name,
      required super.style,
      required super.showDescription,
      required super.popUp});

  factory UserDetailBadgeModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDetailBadgeModel(
        code: jsonData['code'],
        description: jsonData['description'],
        imageUrl: jsonData['image_url'],
        name: jsonData['name'],
        style: jsonData['style'],
        showDescription: jsonData['show_description'],
        popUp: jsonData['popup']);
  }
}
