import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  final String nickname;
  final String avatar;
  final int clientId;
  final String miniBio;
  final String skills;
  final String activity;

  UserDetailProfileModel({
    @required this.nickname,
    @required this.avatar,
    @required this.clientId,
    @required this.miniBio,
    @required this.skills,
    @required this.activity,
  }) : super(
          nickname: nickname,
          avatar: avatar,
          clientId: clientId,
          miniBio: miniBio,
          skills: skills,
          activity: activity,
        );

  factory UserDetailProfileModel.fromJson(Map<String, Object> jsonData) {
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
