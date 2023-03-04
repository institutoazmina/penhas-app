import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  final IApiProvider apiProvider = MockApiProvider();
  final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);
  group('UsersRepository', () {
    test('should send a reason on the body', () async {
      int clientId = 6543;
      final bodyContent =
          await JsonUtil.getJson(from: 'users/users_report.json');
      when(
        () => apiProvider.post(
          path: '/profile/$clientId/report',
          body: bodyContent.toString(),
        ),
      );

      sut.report(clientId, bodyContent['reason']);

      verify(() => apiProvider.post(
            path: '/profile/$clientId/report',
            body: bodyContent.toString(),
          )).called(1);
    });
  });
}
