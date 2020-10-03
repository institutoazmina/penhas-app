import 'package:meta/meta.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

import 'user_detail_profile_model.dart';

class UserSearchSessionModel extends UserSearchSessionEntity {
  final bool hasMore;
  final String nextPage;
  final List<UserDetailProfileModel> users;

  UserSearchSessionModel({
    @required this.hasMore,
    @required this.nextPage,
    @required this.users,
  });

  factory UserSearchSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonProfiles = jsonData["rows"];
    final List<UserDetailProfileModel> users = jsonProfiles
        .map((e) => e as Map<String, Object>)
        .map((e) => UserDetailProfileModel.fromJson(e))
        .where((e) => e != null)
        .toList();

    return UserSearchSessionModel(
      hasMore: jsonData["has_more"] == 1,
      nextPage: jsonData["next_page"],
      users: users,
    );
  }
}
