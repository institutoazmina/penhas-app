import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/models/user_search_session_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';
import 'package:penhas/app/features/users/domain/entities/user_search_options.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IUsersRepository sut;
  late IApiProvider apiProvider;
  const String jsonFile = 'users/users_search.json';

  setUp(() {
    apiProvider = MockApiProvider();
    sut = UsersRepository(
      apiProvider: apiProvider,
    );
  });

  void _setUpMockGet({String? from}) {
    final jsonContent = from ?? jsonFile;

    when(
      () => apiProvider.get(
        path: any(named: 'path'),
        headers: any(named: 'headers'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => JsonUtil.getString(from: jsonContent));
  }

  group(UsersRepository, () {
    group('search', () {
      test(
          'inform at least rows parameter to server for empty UserSearchOptions',
          () async {
        // arrange
        final options = UserSearchOptions();
        _setUpMockGet();
        // act
        await sut.search(options);
        // assert
        verify(
          () => apiProvider.get(
            path: '/search-users',
            parameters: {
              'name': null,
              'skills': null,
              'rows': '100',
              'next_page': null
            },
          ),
        );
      });
      test('inform skill as appended by "," as parameter to server', () async {
        // arrange
        final options = UserSearchOptions(skills: ['a', 'b', 'c']);
        _setUpMockGet();
        // act
        await sut.search(options);
        // assert
        verify(
          () => apiProvider.get(
            path: '/search-users',
            parameters: {
              'name': null,
              'skills': 'a,b,c',
              'rows': '100',
              'next_page': null
            },
          ),
        );
      });
      test('return empty session for no search result', () async {
        // arrange
        const jsonEmptySession = 'users/users_search_empty.json';
        final jsonData = await JsonUtil.getJson(from: jsonEmptySession);
        final actual = right(UserSearchSessionModel.fromJson(jsonData));
        final options = UserSearchOptions(skills: ['a', 'b', 'c']);
        _setUpMockGet(from: jsonEmptySession);
        // act
        final matcher = await sut.search(options);
        // assert
        expect(actual, matcher);
      });
      test('return full session for search with results', () async {
        // arrange
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(UserSearchSessionModel.fromJson(jsonData));
        final options = UserSearchOptions(skills: ['a', 'b', 'c']);
        _setUpMockGet();
        // act
        final matcher = await sut.search(options);
        // assert
        expect(actual, matcher);
      });

      test('apiProvider exception return Failure', () async {
        // arrange
        final expected = left(ServerFailure());
        final options = UserSearchOptions(skills: ['a', 'b', 'c']);

        when(() => apiProvider.get(
              path: any(named: 'path'),
              headers: any(named: 'headers'),
              parameters: any(named: 'parameters'),
            )).thenThrow(Exception());
        // act
        final actual = await sut.search(options);
        // assert
        expect(actual, expected);
      });
    });
  });
}
