import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  final String email;
  final String nickname;
  final String avatar;
  final bool stealthModeEnabled;
  final bool anonymousModeEnabled;

  UserProfileModel({
    @required this.email,
    @required this.nickname,
    @required this.avatar,
    @required this.stealthModeEnabled,
    @required this.anonymousModeEnabled,
  });

  UserProfileModel.fromJson(Map<String, Object> jsonData)
      : email = jsonData['email'],
        nickname = jsonData['apelido'],
        avatar = jsonData['avatar_url'],
        stealthModeEnabled = jsonData['modo_camuflado_ativo'] == 1,
        anonymousModeEnabled = jsonData['modo_anonimo_ativo'] == 1;

  Map<String, Object> toJson() => {
        'apelido': nickname,
        'avatar_url': avatar,
      };
}
