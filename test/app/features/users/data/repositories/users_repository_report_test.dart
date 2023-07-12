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
  String reason = 'Hate speech';
  final parameters = {'cliente_id': clientId, 'reason': reason};

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
    group('report', () {
      test('apiProvider exception return Failure', () async {
        // arrange
        final expected = left(ServerFailure());
        final serverMessage = await JsonUtil.getJson(
          from: 'users/users_report_cliente_id_not_found.json',
        );

        when(
          () => apiProvider.post(
            path: any(named: 'path'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(serverMessage);

        // act
        final actual = await sut.report(clientId, reason);

        // assert
        expect(actual, expected);
      });

      test('send client_id and reason to report', () async {
        // arrange
        _setUpMockPost();

        // act
        sut.report(clientId, reason);

        // assert
        verify(() => apiProvider.post(
              path: '/report-profile',
              parameters: parameters,
            ));
      });

      test('receive success message', () async {
        // arrange
        _setUpMockPost();
        final expected = right(
          const ValidField(message: 'Sucesso!'),
        );

        // act
        final actual = await sut.report(clientId, reason);

        // assert
        expect(actual, expected);
      });
    });
  });
}
