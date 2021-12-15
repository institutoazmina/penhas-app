import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  const String jsonFile = 'users/users_detail.json';
  late final MockIApiProvider apiProvider = MockIApiProvider();
  late final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);

  group('UsersRepository', () {
    test('should use client_id parameter to server', () async {
      // arrange
      const clientId = '1335';
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.profileDetail(clientId);
      // assert
      verify(apiProvider.get(
        path: '/profile',
        parameters: {'cliente_id': '1335'},
      ),);
    });
    test('should retrieve user profile detail from server', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(UserDetailModel.fromJson(jsonData));
      const clientId = '1335';
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.profileDetail(clientId);
      // assert
      expect(actual, matcher);
    });
  });
}
