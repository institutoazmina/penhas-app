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
      int clientId = 6543;
      when(
        () => apiProvider.post(path: '/profile/$clientId/block'),
      );
      sut.block(clientId);
      verify(() => apiProvider.post(path: '/profile/$clientId/block'));
    });
  });
}
