import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatUserEntity extends Equatable {
  final String activity;
  final String nickname;
  final String avatar;
  final int userId;

  ChatUserEntity({
    @required this.activity,
    @required this.nickname,
    @required this.avatar,
    @required this.userId,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        activity,
        nickname,
        avatar,
        userId,
      ];
}
