import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';

void main() {
  setUp(() {});

  group('NotificationSessionModel', () {
    test('should a subclass of NotificationSessionEntity', () async {
      // act
      final model = NotificationSessionModel();
      // assert
      expect(model, isA<NotificationSessionEntity>());
    });
  });
}
