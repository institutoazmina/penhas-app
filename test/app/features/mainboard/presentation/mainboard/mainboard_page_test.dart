import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_preferences_use_case.dart';
import 'package:penhas/app/features/feed/presentation/compose_tweet/compose_tweet_controller.dart';
import 'package:penhas/app/features/main_menu/presentation/penhas_drawer_controller.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_state.dart';
import 'package:penhas/app/features/mainboard/domain/states/mainboard_store.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_controller.dart';
import 'package:penhas/app/features/mainboard/presentation/mainboard/mainboard_page.dart';
import 'package:penhas/app/features/notification/data/repositories/notification_repository.dart';

import '../../../../../utils/golden_tests.dart';

class MockMainboardStore extends Mock implements MainboardStore {}

class FakePageController extends Fake implements PageController {}

class MockInactivityLogoutUseCase extends Mock
    implements InactivityLogoutUseCase {}

class MockNotificationRepository extends Mock
    implements INotificationRepository {}

class FakeTimer extends Fake implements Timer {}

class MockComposeTweetController extends Mock
    implements ComposeTweetController {}

class MockPenhasDrawerController extends Mock
    implements PenhasDrawerController {}

void main() {
  late MainboardController controller;
  late ComposeTweetController composeTweetController;
  late MainboardStore mainboardStore;
  late InactivityLogoutUseCase inactivityLogoutUseCase;
  late INotificationRepository notification;
  late Timer notificationTimer;
  late PageController pageController;
  late PenhasDrawerController penhasDrawerController;

  setUp(() {
    mainboardStore = MockMainboardStore();
    inactivityLogoutUseCase = MockInactivityLogoutUseCase();
    notification = MockNotificationRepository();
    notificationTimer = FakeTimer();
    pageController = FakePageController();
    penhasDrawerController = MockPenhasDrawerController();
    when(() => mainboardStore.selectedPage).thenReturn(MainboardState.feed());
    when(() => mainboardStore.pages).thenReturn(([
      MainboardState.feed(),
      MainboardState.escapeManual(),
      MainboardState.helpCenter(),
      MainboardState.chat(),
      MainboardState.supportPoint(),
    ]).asObservable());

    when(() => pageController.initialPage).thenReturn(0);
    when(() => mainboardStore.pageController).thenReturn(pageController);
    controller = MainboardController(
      mainboardStore: mainboardStore,
      inactivityLogoutUseCase: inactivityLogoutUseCase,
      notification: notification,
      notificationTimer: notificationTimer,
    );
    composeTweetController = MockComposeTweetController();
  });

  group(MainboardPage, () {
    screenshotTest(
      'mainboard page',
      fileName: 'mainboard_page',
      pageBuilder: () => MainboardPage(
        controller: controller,
        composeTweetController: composeTweetController,
        penhasDrawerController: penhasDrawerController,
      ),
      skip: true,
      reason:
          'possuiu vários elementos difíceis de testar. Vou revisar esta tela para melhorar a cobertura de testes',
    );
  });
}
