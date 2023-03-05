import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  final IApiProvider apiProvider = MockApiProvider();
  final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);
  group('UsersRepository', () {
    test('should pass clientId on path', () async {
      String clientId = '6543';
      final parameters = {'cliente_id': clientId};
      when(
        () => apiProvider.post(
          path: any(named: 'path'),
          parameters: any(named: 'parameters'),
        ),
      );

      sut.block(clientId);
      verify(() =>
          apiProvider.post(path: '/profile-block', parameters: parameters));
    });
  });
}
