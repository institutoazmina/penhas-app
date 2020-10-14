import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';

import 'user_detail_profile_model.dart';

@immutable
class UserDetailModel extends UserDetailEntity {
  final bool isMyself;
  final UserDetailProfileModel profile;

  UserDetailModel({
    @required this.isMyself,
    @required this.profile,
  }) : super(isMyself: isMyself, profile: profile);

  factory UserDetailModel.fromJson(Map<String, Object> jsonData) {
    return UserDetailModel(
      isMyself: jsonData["is_myself"] == 1,
      profile: UserDetailProfileModel.fromJson(jsonData["profile"]),
    );
  }
}