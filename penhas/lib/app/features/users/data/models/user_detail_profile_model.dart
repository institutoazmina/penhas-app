import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

class UserDetailProfileModel extends UserDetailProfileEntity {
  final String? nickname;
  final String? avatar;
  final int? clientId;
  final String? miniBio;
  final String? skills;
  final String? activity;

  UserDetailProfileModel({
    required this.nickname,
    required this.avatar,
    required this.clientId,
    required this.miniBio,
    required this.skills,
    required this.activity,
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
      nickname: jsonData['apelido'] as String?,
      avatar: jsonData['avatar_url'] as String?,
      clientId: jsonData['cliente_id'] as int?,
      skills: jsonData['skills'] as String?,
      activity: jsonData['activity'] as String?,
      miniBio: jsonData['minibio'] as String?,
    );
  }
}
