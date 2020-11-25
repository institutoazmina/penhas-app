import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class UserProfileEntity extends Equatable {
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

  UserProfileEntity({
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
  });

  @override
  List<Object> get props => [
        this.fullName,
        this.race,
        this.genre,
        this.jaFoiVitimaDeViolencia,
        this.skill,
        this.email,
        this.nickname,
        this.avatar,
        this.minibio,
        this.stealthModeEnabled,
        this.anonymousModeEnabled,
        this.birthdate,
      ];

  @override
  bool get stringify => true;
}
