import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    String? fullName,
    String? email,
    String? genre,
    String? race,
    bool jaFoiVitimaDeViolencia = false,
    List<String> skill = const [],
    String? nickname,
    String? avatar,
    String? minibio,
    bool stealthModeEnabled = false,
    bool anonymousModeEnabled = false,
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
      skill: (jsonData["skills"] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
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
        'skills': skill
      };
}
