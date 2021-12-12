import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    required String? fullName,
    required String? email,
    required String? genre,
    required String? race,
    required bool jaFoiVitimaDeViolencia,
    required List<String>? skill,
    required String? nickname,
    required String? avatar,
    required String? minibio,
    required bool stealthModeEnabled,
    required bool anonymousModeEnabled,
    required DateTime birthdate,
  }) : super(
          fullName: fullName,
          race: race,
          genre: genre,
          jaFoiVitimaDeViolencia: jaFoiVitimaDeViolencia,
          skill: skill,
          email: email,
          avatar: avatar,
          nickname: nickname,
          minibio: minibio,
          stealthModeEnabled: stealthModeEnabled,
          anonymousModeEnabled: anonymousModeEnabled,
          birthdate: birthdate,
        );

  factory UserProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return UserProfileModel(
      email: jsonData['email'],
      nickname: jsonData['apelido'],
      avatar: jsonData['avatar_url'],
      stealthModeEnabled: jsonData['modo_camuflado_ativo'] == 1,
      anonymousModeEnabled: jsonData['modo_anonimo_ativo'] == 1,
      birthdate: DateTime.parse(jsonData['dt_nasc'] as String),
      fullName: jsonData["nome_completo"],
      minibio: jsonData["minibio"],
      race: jsonData["raca"],
      genre: jsonData["genero"],
      jaFoiVitimaDeViolencia: jsonData["ja_foi_vitima_de_violencia"] == 1,
      skill: (jsonData["skills"] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'apelido': nickname,
        'avatar_url': avatar,
        'modo_camuflado_ativo': stealthModeEnabled ?? false ? 1 : 0,
        'modo_anonimo_ativo': anonymousModeEnabled ?? false ? 1 : 0,
        'dt_nasc': birthdate.toIso8601String(),
        'nome_completo': fullName,
        'minibio': minibio,
        'raca': race,
        'genero': genre,
<<<<<<< HEAD
        'ja_foi_vitima_de_violencia': jaFoiVitimaDeViolencia ? 1 : 0,
=======
        'ja_foi_vitima_de_violencia': jaFoiVitimaDeViolencia ?? false ? 1 : 0,
>>>>>>> Fix code syntax
        'skills': skill
      };
}
