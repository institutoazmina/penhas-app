import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/network/api_client.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

import '../../../../../utils/json_util.dart';

class MockApiProvider extends Mock implements IApiProvider {}

void main() {
  late IApiProvider apiProvider;
  late INotificationRepository sut;

  setUpAll(() {
    apiProvider = MockApiProvider();
    sut = NotificationRepository(apiProvider: apiProvider);
  });

  group(NotificationRepository, () {
    test(
      'get a NotificationSessionModel from a successful server response',
      () async {
        // arrange
        const jsonFile = 'notification/notification_session.json';
        final jsonData = await JsonUtil.getJson(from: jsonFile);
        final actual = right(NotificationSessionModel.fromJson(jsonData));
        when(
          () => apiProvider.get(
            path: any(named: 'path'),
            headers: any(named: 'headers'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
        // act
        final matcher = await sut.notifications();
        // assert
        expect(actual, matcher);
      },
    );
  });
}
