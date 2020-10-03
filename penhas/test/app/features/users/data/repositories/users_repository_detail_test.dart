import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/models/user_detail_profile_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  String jsonFile;
  IApiProvider apiProvider;
  IUsersRepository sut;

  setUp(() {
    jsonFile = 'users/users_detail.json';
    apiProvider = MockApiProvider();
    sut = UsersRepository(apiProvider: apiProvider);
  });

  group('UsersRepository', () {
    test('should use client_id parameter to server', () async {
      // arrange
      final profile = UserDetailProfileModel(
          nickname: null,
          avatar: null,
          clientId: 1335,
          miniBio: null,
          skills: null,
          activity: null);
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.profileDetail(profile);
      // assert
      verify(apiProvider.get(
        path: "/profile",
        parameters: {"cliente_id": "1335"},
      ));
    });
    test('should retrieve user profile detail from server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(UserDetailModel.fromJson(jsonData));
      final profile = UserDetailProfileModel(
          nickname: null,
          avatar: null,
          clientId: 1335,
          miniBio: null,
          skills: null,
          activity: null);
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.profileDetail(profile);
      // assert
      expect(actual, matcher);
    });
  });
}
