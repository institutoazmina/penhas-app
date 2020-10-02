import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  group('UserProfileModel', () {
    test('should be a subclass of UserProfileEntity', () async {
      // act
      final profileModel = UserProfileModel(
        avatar: null,
        nickname: null,
        email: null,
        stealthModeEnabled: null,
        anonymousModeEnabled: null,
        birthdate: DateTime(1980, 3, 3),
      );
      // assert
      expect(profileModel, isA<UserProfileEntity>());
    });

    test('should return a valid model from a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final Map<String, Object> userProfileData = jsonData['user_profile'];
      final expected = UserProfileModel(
        email: userProfileData['email'],
        nickname: userProfileData['apelido'],
        avatar: userProfileData['avatar_url'],
        anonymousModeEnabled: userProfileData['modo_anonimo_ativo'] == 1,
        stealthModeEnabled: userProfileData['modo_camuflado_ativo'] == 1,
        birthdate: DateTime(1980, 3, 3),
      );
      // act
      final received = UserProfileModel.fromJson(userProfileData);
      // assert
      expect(received, expected);
    });

    test('should return a valid JSON from a model', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final Map<String, Object> userProfileData = jsonData['user_profile'];
      final Map<String, Object> expected = {
        'email': userProfileData['email'],
        'apelido': userProfileData['apelido'],
        'avatar_url': userProfileData['avatar_url'],
        'modo_anonimo_ativo': userProfileData['modo_anonimo_ativo'],
        'modo_camuflado_ativo': userProfileData['modo_camuflado_ativo'],
        'dt_nasc': '1980-03-03T00:00:00.000',
      };
      final userModel = UserProfileModel(
        email: userProfileData['email'],
        nickname: userProfileData['apelido'],
        avatar: userProfileData['avatar_url'],
        anonymousModeEnabled: userProfileData['modo_anonimo_ativo'] == 1,
        stealthModeEnabled: userProfileData['modo_camuflado_ativo'] == 1,
        birthdate: DateTime(1980, 3, 3),
      );
      // act
      final received = userModel.toJson();
      // assert
      expect(received, expected);
    });
  });
}
