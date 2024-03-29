import 'package:meta/meta.dart';

import '../../domain/entities/user_detail_entity.dart';
import 'user_detail_profile_model.dart';

@immutable
class UserDetailModel extends UserDetailEntity {
  const UserDetailModel({
    required bool isMyself,
    required UserDetailProfileModel profile,
  }) : super(isMyself: isMyself, profile: profile);

  factory UserDetailModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDetailModel(
      isMyself: jsonData['is_myself'] == 1,
      profile: UserDetailProfileModel.fromJson(
        jsonData['profile'] as Map<String, dynamic>,
      ),
    );
  }
}
