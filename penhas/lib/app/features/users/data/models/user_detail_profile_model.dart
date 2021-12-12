import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  UserDetailProfileModel({
    required String? nickname,
    required String? avatar,
    required int? clientId,
    required String? miniBio,
    required String? skills,
    required String? activity,
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
