import 'package:collection/collection.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

class UserSearchSessionModel extends UserSearchSessionEntity {
  final bool hasMore;
  final String? nextPage;
  final List<UserDetailProfileModel>? users;

  UserSearchSessionModel({
    required this.hasMore,
    required this.nextPage,
    required this.users,
  });

  factory UserSearchSessionModel.fromJson(Map<String, Object> jsonData) {
    final List<Object> jsonProfiles = jsonData["rows"] as List<Object>;
    final List<UserDetailProfileModel> users = jsonProfiles
        .map((e) => UserDetailProfileModel.fromJson(e))
        .whereNotNull()
        .toList();

    return UserSearchSessionModel(
      hasMore: jsonData["has_more"] == 1,
      nextPage: jsonData["next_page"] as String?,
      users: users,
    );
  }
}
