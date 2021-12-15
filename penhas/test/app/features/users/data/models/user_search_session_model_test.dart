import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/data/models/user_search_session_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  final String jsonFile = "users/users_search.json";

  group('UserSearchSessionModel', () {
    test('should be a subclass of UserDetailEntity', () async {
      // arrange
      const model = UserSearchSessionModel(
        hasMore: false,
        nextPage: 'my_secret_pagination_token',
        users: null,
      );
      // assert
      expect(model, isA<UserSearchSessionEntity>());
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      const avatar = 'https://api.example.com/avatar/padrao.svg';
      final users = [
        const UserDetailProfileModel(
          activity: 'há alguns dias',
          nickname: 'Maria',
          avatar: avatar,
          clientId: 180,
          skills: 'Escuta acolhedora',
        ),
        const UserDetailProfileModel(
          activity: 'há alguns dias',
          nickname: 'Julia',
          avatar: avatar,
          clientId: 3191,
          skills: 'Psicologia',
        ),
        const UserDetailProfileModel(
          activity: 'há alguns dias',
          nickname: 'Li',
          avatar: avatar,
          clientId: 3286,
          skills: 'Escuta acolhedora',
        ),
        const UserDetailProfileModel(
          activity: 'há algumas semanas',
          nickname: 'Lilo',
          avatar: avatar,
          clientId: 3264,
          skills: 'Escuta acolhedora',
        ),
        const UserDetailProfileModel(
          activity: 'há algumas semanas',
          nickname: 'Patricia',
          avatar: avatar,
          clientId: 1196,
          skills: 'Escuta acolhedora, Saúde e bem estar',
        ),
        const UserDetailProfileModel(
          activity: 'há muito tempo',
          nickname: 'Leticia',
          avatar: avatar,
          clientId: 1335,
          skills: '',
        ),
      ];
      final actual = UserSearchSessionModel(
        hasMore: true,
        nextPage: 'my_secret_pagination_token',
        users: users,
      );
      // act
      final matcher = UserSearchSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });

    test('should return empty model with a empty JSON', () async {
      // arrange
      const jsonFileEmpty = 'users/users_search_empty.json';
      final jsonData = await JsonUtil.getJson(from: jsonFileEmpty);
      const actual = UserSearchSessionModel(
        hasMore: false,
        nextPage: null,
        users: [],
      );
      // act
      final matcher = UserSearchSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
