import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  String? jsonFile;
  IApiProvider? apiProvider;
  late IUsersRepository sut;

  setUp(() {
    jsonFile = 'users/users_detail.json';
    apiProvider = MockApiProvider();
    sut = UsersRepository(apiProvider: apiProvider);
  });

  group('UsersRepository', () {
    test('should use client_id parameter to server', () async {
      // arrange
<<<<<<< HEAD
      const clientId = '1335';
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.profileDetail(clientId);
      // assert
      verify(
        apiProvider.get(
          path: '/profile',
          parameters: {'cliente_id': '1335'},
        ),
      );
=======
      final clientId = "1335";
      when(apiProvider!.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.profileDetail(clientId);
      // assert
      verify(apiProvider!.get(
        path: "/profile",
        parameters: {"cliente_id": "1335"},
      ));
>>>>>>> Migrate code to nullsafety
    });
    test('should retrieve user profile detail from server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(UserDetailModel.fromJson(jsonData));
<<<<<<< HEAD
      const clientId = '1335';
      when(
        apiProvider.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
=======
      final clientId = "1335";
      when(apiProvider!.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      )).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
>>>>>>> Migrate code to nullsafety
      // act
      final matcher = await sut.profileDetail(clientId);
      // assert
      expect(actual, matcher);
    });
  });
}
