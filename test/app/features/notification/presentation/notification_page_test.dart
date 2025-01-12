import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/notification/data/models/notification_session_model.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';
import 'package:penhas/app/features/notification/domain/entities/notification_session_entity.dart';
import 'package:penhas/app/features/notification/presentation/notification_controller.dart';
import 'package:penhas/app/features/notification/presentation/notification_page.dart';

import '../../../../utils/golden_tests.dart';

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

void main() {
  late NotificationController controller;
  late INotificationRepository repository;

  setUp(() {
    repository = MockNotificationRepository();
    controller = NotificationController(notificationRepository: repository);
  });

  group(NotificationPage, () {
    testWidgets('should display the notification page', (tester) async {
      // arrange
      final notificationSession = NotificationSessionModel(
        notifications: [],
        hasMore: false,
        nextPage: 'asb',
      );
      when(() => repository.notifications())
          .thenAnswer((_) async => right(notificationSession));
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: NotificationPage(controller: controller),
        ),
      );

      // assert
      expect(find.text('Notificações'), findsOneWidget);
      expect(find.text('Carregando...'), findsOneWidget);
    });

    screenshotTest(
      'notification page empty state',
      fileName: 'notification_page_empty',
      pageBuilder: () => NotificationPage(controller: controller),
      setUp: () {
        when(() => repository.notifications())
            .thenAnswer((_) async => right(NotificationSessionModel(
                  notifications: [],
                  hasMore: false,
                  nextPage: 'asb',
                )));
      },
    );

    screenshotTest(
      'notification page loaded state',
      fileName: 'notification_page_loaded',
      pageBuilder: () => NotificationPage(controller: controller),
      setUp: () {
        final notificationSession = NotificationSessionModel(
          notifications: [
            NotificationEntity(
              name: 'Notification 1',
              content: 'Message 1',
              time: DateTime(2024),
              icon: null,
              title: 'Notification Title 1',
            ),
            NotificationEntity(
              name: 'Notification 2',
              content: 'Message 2',
              time: DateTime(2024),
              icon: '',
              title: 'Notification Title 2',
            ),
            NotificationEntity(
              name: 'Notification 3',
              content: 'Message 3',
              time: DateTime(2024),
              icon: null,
              title: 'Notification Title 3',
            ),
          ],
          hasMore: false,
          nextPage: 'asb',
        );
        when(() => repository.notifications())
            .thenAnswer((_) async => right(notificationSession));
      },
    );
  });
}
