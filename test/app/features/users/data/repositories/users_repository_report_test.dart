import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/users/data/repositories/users_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  late final MockIApiProvider apiProvider = MockIApiProvider();
  late final IUsersRepository sut = UsersRepository(apiProvider: apiProvider);
  group('UsersRepository', () {
    test('should send a reason on the body', () async {
      int clientId = 6543;
      final bodyContent =
          await JsonUtil.getJson(from: 'users/users_report.json');
      when(
        apiProvider.post(
          path: '/profile/$clientId/report',
          body: bodyContent.toString(),
        ),
      );

      sut.report(clientId, bodyContent['reason']);

      verify(apiProvider.post(
        path: '/profile/$clientId/report',
        body: bodyContent.toString(),
      ));
    });
  });
}
