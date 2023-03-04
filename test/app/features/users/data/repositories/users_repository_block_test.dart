import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/helper.mocks.dart';

void main() {
  late final MockIApiProvider apiProvider = MockIApiProvider();
  late final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);
  group('UsersRepository', () {
    test('should pass clientId on path', () async {
      int clientId = 6543;
      when(
        apiProvider.post(path: '/profile/$clientId/block'),
      );
      sut.block(clientId);
      verify(apiProvider.post(path: '/profile/$clientId/block'));
    });
  });
}
