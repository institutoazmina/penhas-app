import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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

  group('UsersRepository', () {
    test('should throw error for invalid client id', () async {
      final response = await JsonUtil.getJson(
        from: 'users/users_block_cliente_id_invalid.json',
      );

      final error = ServerFailure();

      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(response);

      final result = await sut.block(clientId);

      expect(result, left(error));
    });
    test('should send client_id to block', () async {
      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async => '{"message": "Sucesso!"}');

      sut.block(clientId);
      verify(() =>
          apiProvider.post(path: '/profile-block', parameters: parameters));
    });
  });
}
