import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/data/models/user_search_session_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String jsonFile;

  setUp(() {
    jsonFile = "users/users_search.json";
  });

  group('UserSearchSessionModel', () {
    test('should be a subclass of UserDetailEntity', () async {
      // arrange
      final model = UserSearchSessionModel(
        hasMore: false,
        nextPage: "my_secret_pagination_token",
        users: null,
      );
      // assert
      expect(model, isA<UserSearchSessionEntity>());
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final avatar = "https://api.example.com/avatar/padrao.svg";
      final users = [
        UserDetailProfileModel(
          activity: "há alguns dias",
          nickname: "Maria",
          avatar: avatar,
          clientId: 180,
          skills: "Escuta acolhedora",
          miniBio: null,
        ),
        UserDetailProfileModel(
          activity: "há alguns dias",
          nickname: "Julia",
          avatar: avatar,
          clientId: 3191,
          skills: "Psicologia",
          miniBio: null,
        ),
        UserDetailProfileModel(
          activity: "há alguns dias",
          nickname: "Li",
          avatar: avatar,
          clientId: 3286,
          skills: "Escuta acolhedora",
          miniBio: null,
        ),
        UserDetailProfileModel(
          activity: "há algumas semanas",
          nickname: "Lilo",
          avatar: avatar,
          clientId: 3264,
          skills: "Escuta acolhedora",
          miniBio: null,
        ),
        UserDetailProfileModel(
          activity: "há algumas semanas",
          nickname: "Patricia",
          avatar: avatar,
          clientId: 1196,
          skills: "Escuta acolhedora, Saúde e bem estar",
          miniBio: null,
        ),
        UserDetailProfileModel(
          activity: "há muito tempo",
          nickname: "Leticia",
          avatar: avatar,
          clientId: 1335,
          skills: "",
          miniBio: null,
        ),
      ];
      final actual = UserSearchSessionModel(
        hasMore: true,
        nextPage: "my_secret_pagination_token",
        users: users,
      );
      // act
      final matcher = UserSearchSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });

    test('should return empty model with a empty JSON', () async {
      // arrange
      final jsonFileEmpty = "users/users_search_empty.json";
      final jsonData = await JsonUtil.getJson(from: jsonFileEmpty);
      final actual = UserSearchSessionModel(
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
