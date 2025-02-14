import '../../domain/entities/user_detail_badge_entity.dart';
import '../../domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  const UserDetailProfileModel({
    String? nickname,
    String? avatar,
    int? clientId,
    String? miniBio,
    String? skills,
    String? activity,
    List<UserDetailBadgeEntity>? badges,
  }) : super(
          nickname: nickname,
          avatar: avatar,
          clientId: clientId,
          miniBio: miniBio,
          skills: skills,
          activity: activity,
          badges: badges,
        );

  factory UserDetailProfileModel.fromJson(Map<String, dynamic> jsonData) {
    List<UserDetailBadgeEntity>? badges;

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
      {required String code,
      required String description,
      required String imageUrl,
      required String name,
      required String style,
      required int showDescription,
      required int popUp})
      : super(
            code: code,
            description: description,
            imageUrl: imageUrl,
            name: name,
            style: style,
            showDescription: showDescription,
            popUp: popUp);

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
