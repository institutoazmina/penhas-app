import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

@immutable
class UserSearchSessionEntity extends Equatable {
  final bool hasMore;
  final String? nextPage;
  final List<UserDetailProfileEntity>? users;

  UserSearchSessionEntity({
    required this.hasMore,
    required this.nextPage,
    required this.users,
  });

  final bool hasMore;
  final String? nextPage;
  final List<UserDetailProfileEntity>? users;

  @override
  List<Object?> get props => [
        hasMore,
        nextPage,
        users,
      ];

  @override
  bool get stringify => true;
}
