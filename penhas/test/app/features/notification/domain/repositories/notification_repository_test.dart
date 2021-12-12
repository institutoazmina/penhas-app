import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

import '../../../../../utils/helper.mocks.dart';
import '../../../../../utils/json_util.dart';

void main() {
  IApiProvider? apiProvider;
  late INotificationRepository sut;

  setUp(() {
    apiProvider = MockApiProvider();
    sut = NotificationRepository(apiProvider: apiProvider);
  });

  group('NotificationRepository', () {
    test(
        'should get a NotificationSessionModel from a successful server response',
        () async {
      // arrange
      const jsonFile = 'notification/notification_session.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = right(NotificationSessionModel.fromJson(jsonData));
      when(
        apiProvider!.get(
          path: anyNamed('path'),
          headers: anyNamed('headers'),
          parameters: anyNamed('parameters'),
        ),
      ).thenAnswer((_) => JsonUtil.getString(from: jsonFile));
      // act
      final matcher = await sut.notifications();
      // assert
      expect(actual, matcher);
    });
  });
}
