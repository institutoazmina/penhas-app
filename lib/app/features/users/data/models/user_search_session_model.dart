import 'package:collection/collection.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

class UserSearchSessionModel extends UserSearchSessionEntity {
  const UserSearchSessionModel({
    required bool hasMore,
    required String? nextPage,
    required List<UserDetailProfileModel>? users,
  }) : super(hasMore: hasMore, nextPage: nextPage, users: users);

  factory UserSearchSessionModel.fromJson(Map<String, dynamic> jsonData) {
    final List jsonProfiles = jsonData['rows'];
    final List<UserDetailProfileModel> users = jsonProfiles
        .map((e) => UserDetailProfileModel.fromJson(e))
        .whereNotNull()
        .toList();

    return UserSearchSessionModel(
      hasMore: jsonData['has_more'] == 1,
      nextPage: jsonData['next_page'],
      users: users,
    );
  }
}
