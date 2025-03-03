import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  group('UserProfileModel', () {
    test('should be a subclass of UserProfileEntity', () async {
      // act
      final profileModel = UserProfileModel(
        birthdate: DateTime(1980, 3, 3),
        fullName: 'Fulana da Silva',
        race: 'pardo',
        genre: 'Feminino',
      );
      // assert
      expect(profileModel, isA<UserProfileEntity>());
    });

    test('should return a valid model from a valid JSON', () async {
      // arrange
      final jsonData =
          await JsonUtil.getJson(from: 'profile/about_with_quiz_session.json');
      final Map<String, dynamic> userProfileData = jsonData['user_profile'];
      final expected = UserProfileModel(
        email: userProfileData['email'] as String?,
        nickname: userProfileData['apelido'] as String?,
        avatar: userProfileData['avatar_url'] as String?,
        anonymousModeEnabled: userProfileData['modo_anonimo_ativo'] == 1,
        stealthModeEnabled: userProfileData['modo_camuflado_ativo'] == 1,
        birthdate: DateTime(1980, 3, 3),
        fullName: userProfileData['nome_completo'] as String?,
        race: userProfileData['raca'] as String?,
        genre: userProfileData['genero'] as String?,
        jaFoiVitimaDeViolencia:
            userProfileData['ja_foi_vitima_de_violencia'] == 1,
        minibio: userProfileData['minibio'] as String?,
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
      final Map<String, dynamic> userProfileData = jsonData['user_profile'];
      final Map<String, Object?> expected = {
        'email': userProfileData['email'],
        'apelido': userProfileData['apelido'],
        'avatar_url': userProfileData['avatar_url'],
        'modo_anonimo_ativo': userProfileData['modo_anonimo_ativo'],
        'modo_camuflado_ativo': userProfileData['modo_camuflado_ativo'],
        'dt_nasc': '1980-03-03T00:00:00.000',
        'nome_completo': 'Fulana da Silva',
        'minibio': null,
        'raca': 'pardo',
        'genero': 'Feminino',
        'ja_foi_vitima_de_violencia': 0,
        'skills': [],
        'badges': [],
      };
      final userModel = UserProfileModel(
        email: userProfileData['email'] as String?,
        nickname: userProfileData['apelido'] as String?,
        avatar: userProfileData['avatar_url'] as String?,
        anonymousModeEnabled: userProfileData['modo_anonimo_ativo'] == 1,
        stealthModeEnabled: userProfileData['modo_camuflado_ativo'] == 1,
        birthdate: DateTime(1980, 3, 3),
        fullName: userProfileData['nome_completo'] as String?,
        race: userProfileData['raca'] as String?,
        genre: userProfileData['genero'] as String?,
        jaFoiVitimaDeViolencia:
            userProfileData['ja_foi_vitima_de_violencia'] == 1,
        minibio: userProfileData['minibio'] as String?,
      );
      // act
      final received = userModel.toJson();
      // assert
      expect(received, expected);
    });
  });
}
