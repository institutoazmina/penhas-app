import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  final String email;
  final String avatar;
  final String nickname;
  final String fullName;
  final String minibio;
  final String race;
  final String genre;
  final bool stealthModeEnabled;
  final bool anonymousModeEnabled;
  final bool jaFoiVitimaDeViolencia;
  final DateTime birthdate;
  final List<String> skill;

  UserProfileModel({
    @required this.fullName,
    @required this.race,
    @required this.genre,
    @required this.jaFoiVitimaDeViolencia,
    @required this.skill,
    @required this.email,
    @required this.nickname,
    @required this.avatar,
    @required this.minibio,
    @required this.stealthModeEnabled,
    @required this.anonymousModeEnabled,
    @required this.birthdate,
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

  UserProfileModel.fromJson(Map<String, Object> jsonData)
      : email = jsonData['email'],
        nickname = jsonData['apelido'],
        avatar = jsonData['avatar_url'],
        stealthModeEnabled = jsonData['modo_camuflado_ativo'] == 1,
        anonymousModeEnabled = jsonData['modo_anonimo_ativo'] == 1,
        birthdate = DateTime.parse(jsonData['dt_nasc']),
        fullName = jsonData["nome_completo"],
        minibio = jsonData["minibio"],
        race = jsonData["raca"],
        genre = jsonData["genero"],
        jaFoiVitimaDeViolencia = jsonData["ja_foi_vitima_de_violencia"] == 1,
        skill = (jsonData["skills"] as List<Object>)
            .map((e) => e.toString())
            .toList();

  Map<String, Object> toJson() => {
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
        'ja_foi_vitima_de_violencia': (jaFoiVitimaDeViolencia ?? false) ? 1 : 0,
        'skills': skill
      };
}
