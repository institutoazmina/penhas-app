import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

import '../../../../../utils/json_util.dart';

void main() {
  group('NotificationSessionModel', () {
    test('should a subclass of NotificationSessionEntity', () async {
      // act
      const model = NotificationSessionModel(
        hasMore: false,
        nextPage: null,
        notifications: null,
      );
      // assert
      expect(model, isA<NotificationSessionEntity>());
    });
    test('should return a valid model with a valid JSON', () async {
      // arrange
      const jsonFile = 'notification/notification_session.json';
      final jsonData = await JsonUtil.getJson(from: jsonFile);
      final actual = NotificationSessionModel(
        hasMore: false,
        nextPage: null,
        notifications: [
          NotificationEntity(
            content: 'Seja bem vindo ao mundo!',
            icon: 'http://elasv2-api.appcivico.com/i/0.svg',
            name: 'PenhaS',
            time: DateTime.parse('2020-11-15T22:54:36Z'),
            title: 'curtiu sua publicação',
          ),
          NotificationEntity(
            content:
                '❝lol❞ na publicação the most popular is not only for you but you are a very popular choice and it can also make a lot ea…',
            icon: 'http://elasv2-api.appcivico.com/i/0.svg',
            name: 'PenhaS',
            time: DateTime.parse('2020-11-15T22:54:26Z'),
            title: 'comentou sua publicação',
          )
        ],
      );
      // act
      final matcher = NotificationSessionModel.fromJson(jsonData);
      // assert
      expect(actual, matcher);
    });
  });
}
