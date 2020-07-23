import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class UserProfileEntity extends Equatable {
  final String nickname;
  final String avatar;

  UserProfileEntity({
    @required this.nickname,
    @required this.avatar,
  });

  @override
  List<Object> get props => [nickname, avatar];

  @override
  bool get stringify => true;
}
