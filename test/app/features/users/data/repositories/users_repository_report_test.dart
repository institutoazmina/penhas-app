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
  String reason = 'Hate speech';
  final parameters = {'cliente_id': clientId, 'reason': reason};

  setUp(() {
    apiProvider = MockApiProvider();
    sut = UsersRepository(
      apiProvider: apiProvider,
    );
  });

  group('UsersRepository', () {
    test('should throw error for client id not found', () async {
      final response = await JsonUtil.getJson(
        from: 'users/users_report_cliente_id_not_found.json',
      );

      final error = ServerFailure();

      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(response);

      final result = await sut.report(clientId, reason);

      expect(result, left(error));
    });

    test('should send client_id and reason to report', () async {
      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      ).thenAnswer((_) async => '{"message": "Sucesso!"}');;

      sut.report(clientId, reason);

      verify(() => apiProvider.post(
            path: '/report-profile',
            parameters: parameters,
          ));
    });
  });
}
