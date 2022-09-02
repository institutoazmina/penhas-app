import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_profile_entity.dart';

@immutable
class UserDetailEntity extends Equatable {
  const UserDetailEntity({
    required this.isMyself,
    required this.profile,
  });

  final bool isMyself;
  final UserDetailProfileEntity profile;

  @override
  List<Object?> get props => [isMyself, profile];

  @override
  bool get stringify => true;
}
