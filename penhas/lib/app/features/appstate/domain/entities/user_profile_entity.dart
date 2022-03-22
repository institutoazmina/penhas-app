import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UserProfileEntity extends Equatable {
  const UserProfileEntity({
    required this.fullName,
    required this.race,
    required this.genre,
    required this.jaFoiVitimaDeViolencia,
    required this.skill,
    required this.email,
    required this.nickname,
    required this.avatar,
    required this.minibio,
    required this.stealthModeEnabled,
    required this.anonymousModeEnabled,
    required this.birthdate,
  });

  final String? email;
  final String? avatar;
  final String? nickname;
  final String? fullName;
  final String? minibio;
  final String? race;
  final String? genre;
  final bool stealthModeEnabled;
  final bool anonymousModeEnabled;
  final bool jaFoiVitimaDeViolencia;
  final DateTime birthdate;
  final List<String> skill;

  @override
  List<Object?> get props => [
        fullName,
        race,
        genre,
        jaFoiVitimaDeViolencia,
        skill,
        email,
        nickname,
        avatar,
        minibio,
        stealthModeEnabled,
        anonymousModeEnabled,
        birthdate,
      ];

  @override
  bool get stringify => true;
}
