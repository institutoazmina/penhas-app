import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IUsersRepository sut;
  late IApiProvider apiProvider;
  String clientId = '6543';
  final parameters = {'cliente_id': clientId};

  setUp(() {
    apiProvider = MockApiProvider();
    sut = UsersRepository(
      apiProvider: apiProvider,
    );
  });

  void _setUpMockPost() {
    when(
      () => apiProvider.post(
        path: any(named: 'path'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => '{"message": "Sucesso!"}');
  }

  group('UsersRepository', () {
    test('should throw error for invalid client id', () async {
      // arrange
      final serverMessage = await JsonUtil.getJson(
        from: 'users/users_block_cliente_id_invalid.json',
      );

      final error = ServerFailure();

      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(serverMessage);

      // act
      final response = await sut.block(clientId);

      // assert
      expect(response, left(error));
    });
    test('should send client_id to block', () async {
      // arrange
      _setUpMockPost();

      // act
      await sut.block(clientId);

      // assert
      verify(() =>
          apiProvider.post(path: '/block-profile', parameters: parameters));
    });

    test('should receive success message', () async {
      // arrange
      _setUpMockPost();

      // act
      final response = await sut.block(clientId);

      // assert
      final expected = right(
        const ValidField(
          message: 'Sucesso!',
        ),
      );
      expect(response, expected);
    });
  });
}
