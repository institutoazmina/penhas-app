import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  String? jsonFile;

  setUp(() {
    jsonFile = 'users/users_detail.json';
  });

  group('UserDetailModel', () {
    test('should be a subclass of UserDetailEntity', () async {
      // arrange
      const model = UserDetailModel(
        isMyself: false,
        profile: UserDetailProfileModel(),
      );
      // assert
      expect(model, isA<UserDetailEntity>());
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      const profile = UserDetailProfileModel(
        nickname: 'Leticia',
        avatar: 'https://api.example.com/avatar/padrao.svg',
        clientId: 1335,
        miniBio: '',
        skills: '',
      );
      const actual = const UserDetailModel(isMyself: false, profile: profile);
      // act
      final matcher = UserDetailModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
