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

  group(UsersRepository, () {
    group('block', () {
      test('apiProvider exception return Failure', () async {
        // arrange
        final expected = left(ServerFailure());
        final serverMessage = await JsonUtil.getJson(
          from: 'users/users_block_cliente_id_invalid.json',
        );

        when(
          () => apiProvider.post(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(serverMessage);

        // act
        final actual = await sut.block(clientId);

        // assert
        expect(actual, expected);
      });
      test('send client_id to block', () async {
        // arrange
        _setUpMockPost();

        // act
        await sut.block(clientId);

        // assert
        verify(() => apiProvider.post(
              path: '/block-profile',
              parameters: parameters,
            ));
      });

      test('receive success message for a valid client id', () async {
        // arrange
        _setUpMockPost();

        // act
        final expected = await sut.block(clientId);

        // assert
        final actual = right(
          const ValidField(
            message: 'Sucesso!',
          ),
        );
        expect(actual, expected);
      });
    });
  });
}
