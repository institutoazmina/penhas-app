import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class UserProfileEntity extends Equatable {
  final String email;
  final String avatar;
  final String nickname;
  final bool stealthModeEnabled;
  final bool anonymousModeEnabled;
  final DateTime birthdate;

  UserProfileEntity({
    @required this.email,
    @required this.nickname,
    @required this.avatar,
    @required this.stealthModeEnabled,
    @required this.anonymousModeEnabled,
    @required this.birthdate,
  });

  @override
  List<Object> get props => [
        email,
        nickname,
        avatar,
        stealthModeEnabled,
        anonymousModeEnabled,
        birthdate,
      ];

  @override
  bool get stringify => true;
}
