import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/models/user_detail_model.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IUsersRepository sut;
  late IApiProvider apiProvider;
  const String jsonFile = 'users/users_detail.json';

  setUp(() {
    apiProvider = MockApiProvider();
    sut = UsersRepository(
      apiProvider: apiProvider,
    );
  });

  void _setUpMockGet() {
    when(
      () => apiProvider.get(
        path: any(named: 'path'),
        headers: any(named: 'headers'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => JsonUtil.getString(from: jsonFile));
  }

  group(UsersRepository, () {
    group('profileDetail', () {
      test('send client_id parameter to server', () async {
        // arrange
        const clientId = '1335';
        _setUpMockGet();
        // act
        await sut.profileDetail(clientId);
        // assert
        verify(
          () => apiProvider.get(
            path: '/profile',
            parameters: {'cliente_id': clientId},
          ),
        );
      });
      test('retrieve user profile detail from server', () async {
        // arrange
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(UserDetailModel.fromJson(jsonData));
        const clientId = '1335';
        _setUpMockGet();
        // act
        final matcher = await sut.profileDetail(clientId);
        // assert
        expect(actual, matcher);
      });

      test('apiProvider exception return Failure', () async {
        // arrange
        final expected = left(ServerFailure());
        final serverMessage = await JsonUtil.getJson(
          from: 'users/users_detail_cliente_id_invalid.json',
        );

        when(
          () => apiProvider.get(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(serverMessage);
        // act
        final actual = await sut.profileDetail('1234');
        // assert
        expect(actual, expected);
      });
    });
  });
}
