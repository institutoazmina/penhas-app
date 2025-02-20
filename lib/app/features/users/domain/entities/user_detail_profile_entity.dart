import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'user_detail_badge_entity.dart';

@immutable
class UserDetailProfileEntity extends Equatable {
  const UserDetailProfileEntity({
    required this.nickname,
    required this.avatar,
    required this.clientId,
    required this.miniBio,
    required this.skills,
    required this.activity,
    required this.badges,
  });

  final String? nickname;
  final String? avatar;
  final int? clientId;
  final String? miniBio;
  final String? skills;
  final String? activity;
  final List<UserDetailBadgeEntity> badges;

  @override
  List<Object?> get props => [
        nickname,
        avatar,
        clientId,
        miniBio,
        skills,
        activity,
        badges,
      ];
}
