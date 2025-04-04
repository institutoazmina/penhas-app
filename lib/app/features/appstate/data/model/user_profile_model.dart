import '../../domain/entities/user_profile_badge_entity.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    super.fullName,
    super.email,
    super.genre,
    super.race,
    super.jaFoiVitimaDeViolencia = false,
    super.skill = const [],
    super.nickname,
    super.avatar,
    super.minibio,
    super.stealthModeEnabled = false,
    super.anonymousModeEnabled = false,
    required super.birthdate,
    super.badges = const [],
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> jsonData) {
    List<UserProfileBadgeEntity> badges = [];
    if (jsonData['badges'] != null) {
      badges = _parseBadges(jsonData['badges']);
    }

    return UserProfileModel(
      email: jsonData['email'],
      nickname: jsonData['apelido'],
      avatar: jsonData['avatar_url'],
      stealthModeEnabled: jsonData['modo_camuflado_ativo'] == 1,
      anonymousModeEnabled: jsonData['modo_anonimo_ativo'] == 1,
      birthdate: DateTime.parse(jsonData['dt_nasc'] as String),
      fullName: jsonData['nome_completo'],
      minibio: jsonData['minibio'],
      race: jsonData['raca'],
      genre: jsonData['genero'],
      jaFoiVitimaDeViolencia: jsonData['ja_foi_vitima_de_violencia'] == 1,
      skill: (jsonData['skills'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      badges: badges,
    );
  }

  static List<UserProfileBadgeEntity> _parseBadges(List<dynamic> badges) {
    return badges.map((e) => UserProfileBadgeModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'apelido': nickname,
        'avatar_url': avatar,
        'modo_camuflado_ativo': stealthModeEnabled ? 1 : 0,
        'modo_anonimo_ativo': anonymousModeEnabled ? 1 : 0,
        'dt_nasc': birthdate.toIso8601String(),
        'nome_completo': fullName,
        'minibio': minibio,
        'raca': race,
        'genero': genre,
        'ja_foi_vitima_de_violencia': jaFoiVitimaDeViolencia ? 1 : 0,
        'skills': skill,
        'badges': badges,
      };
}

class UserProfileBadgeModel extends UserProfileBadgeEntity {
  UserProfileBadgeModel(
      {required super.code,
      required super.description,
      required super.imageUrl,
      required super.name,
      required super.style,
      required super.showDescription,
      required super.popUp});

  factory UserProfileBadgeModel.fromJson(Map<String, dynamic> jsonData) {
    return UserProfileBadgeModel(
        code: jsonData['code'],
        description: jsonData['description'],
        imageUrl: jsonData['image_url'],
        name: jsonData['name'],
        style: jsonData['style'],
        showDescription: jsonData['show_description'],
        popUp: jsonData['popup']);
  }
}
