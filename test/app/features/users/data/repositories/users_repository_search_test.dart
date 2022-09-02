import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/users/data/models/user_search_session_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_options.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  const String jsonFile = 'users/users_search.json';
  late final MockIApiProvider apiProvider = MockIApiProvider();
  late final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);

  group('UsersRepository', () {
    test(
        'should inform at least rows parameter to server for empty UserSearchOptions ',
        () async {
      // arrange
      final options = UserSearchOptions();
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.search(options);
      // assert
      verify(apiProvider.get(
        path: '/search-users',
        parameters: {
          'name': null,
          'skills': null,
          'rows': '100',
          'next_page': null
        },
      ),);
    });
    test('should inform skill as appended by "," as parameter to server',
        () async {
      // arrange
      final options = UserSearchOptions(skills: ['a', 'b', 'c']);
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      await sut.search(options);
      // assert
      verify(apiProvider.get(
        path: '/search-users',
        parameters: {
          'name': null,
          'skills': 'a,b,c',
          'rows': '100',
          'next_page': null
        },
      ),);
    });
    test('should return empty session for no search result', () async {
      // arrange
      const jsonEmptySession = 'users/users_search_empty.json';
      final jsonData = await JsonUtil.getJson(from: jsonEmptySession);
      final actual = right(UserSearchSessionModel.fromJson(jsonData));
      final options = UserSearchOptions(skills: ['a', 'b', 'c']);
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonEmptySession));
      // act
      final matcher = await sut.search(options);
      // assert
      expect(actual, matcher);
    });
    test('should return full session for search with results', () async {
      // arrange
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(UserSearchSessionModel.fromJson(jsonData));
      final options = UserSearchOptions(skills: ['a', 'b', 'c']);
      when(apiProvider.get(
        path: anyNamed('path'),
        headers: anyNamed('headers'),
        parameters: anyNamed('parameters'),
      ),).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.search(options);
      // assert
      expect(actual, matcher);
    });
  });
}
