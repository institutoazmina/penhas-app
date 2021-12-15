import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  UserDetailProfileModel({
    String? nickname,
    String? avatar,
    int? clientId,
    String? miniBio,
    String? skills,
    String? activity,
  }) : super(
          nickname: nickname,
          avatar: avatar,
          clientId: clientId,
          miniBio: miniBio,
          skills: skills,
          activity: activity,
        );

  factory UserDetailProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDetailProfileModel(
      nickname: jsonData['apelido'],
      avatar: jsonData['avatar_url'],
      clientId: jsonData['cliente_id'],
      skills: jsonData['skills'],
      activity: jsonData['activity'],
      miniBio: jsonData['minibio'],
    );
  }
}
