import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  final String email;
  final String nickname;
  final String avatar;

  UserProfileModel({
    @required this.email,
    @required this.nickname,
    @required this.avatar,
  });

  UserProfileModel.fromJson(Map<String, Object> jsonData)
      : email = jsonData['email'],
        nickname = jsonData['apelido'],
        avatar = jsonData['avatar_url'];

  Map<String, Object> toJson() => {
        'apelido': nickname,
        'avatar_url': avatar,
      };
}
