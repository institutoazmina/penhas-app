import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class UserProfileEntity extends Equatable {
  final String email;
  final String avatar;
  final String nickname;

  UserProfileEntity({
    @required this.email,
    @required this.nickname,
    @required this.avatar,
  });

  @override
  List<Object> get props => [email, nickname, avatar];

  @override
  bool get stringify => true;
}
