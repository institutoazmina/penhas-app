import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_action_button.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_felling_page.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_ruling_page.dart';
import 'package:penhas/app/features/zodiac/presentation/pages/zodiac_sign_page.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_controller.dart';
import 'package:penhas/app/features/zodiac/presentation/zodiac_page.dart';

import '../../../../utils/golden_tests.dart';
import '../../../../utils/widget_test_steps.dart';
import '../../authentication/presentation/mocks/app_modules_mock.dart';
import '../../authentication/presentation/mocks/authentication_modules_mock.dart';

void main() {
  late ZodiacController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    final userProfileEntity = UserProfileEntity(
      email: 'test@email.com',
      genre: 'Feminino',
      jaFoiVitimaDeViolencia: false,
      avatar: 'avatar.png',
      fullName: 'Test User',
      stealthModeEnabled: false,
      birthdate: DateTime(1990, 1, 1),
      skill: const ['skill1', 'skill2'],
      anonymousModeEnabled: false,
      race: 'Race',
      nickname: 'Nickname',
      minibio: 'Minibio',
      badges: [],
    );

    when(() => AppModulesMock.userProfileStore.retrieve())
        .thenAnswer((_) async => userProfileEntity);

    when(() => AuthenticationModulesMock.securityAction.isRunning)
        .thenAnswer((_) => Stream.value(false));

    when(() => AuthenticationModulesMock.securityAction.dispose())
        .thenAnswer((_) => Future.value());

    controller = ZodiacController(
      userProfileStore: AppModulesMock.userProfileStore,
      securityAction: AuthenticationModulesMock.securityAction,
    );
  });

  group(ZodiacPage, skip: true, () {
    testWidgets('should render the page', (tester) async {
      // arrange
      await theAppIsRunning(tester, ZodiacPage(controller: controller));
      // assert
      iSeeText('Hoje');
      iSeeText('Diário astrológico');
      iSeeWidget(ZodiacSignPage);
      iSeeWidget(ZodiacRulingPage);
      iSeeWidget(ZodiacFellingPage);
    });

    testWidgets('should call forwardStealthLogin when login button is pressed',
        (tester) async {
      // arrange
      final routeName = '/authentication/sign_in_stealth';
      when(() =>
              AppModulesMock.modularNavigator.pushReplacementNamed(routeName))
          .thenAnswer((_) => Future.value());
      await theAppIsRunning(tester, ZodiacPage(controller: controller));
      // act
      await iTapText(tester, text: 'Diário astrológico');
      // assert
      verify(() =>
              AppModulesMock.modularNavigator.pushReplacementNamed(routeName))
          .called(1);
    });

    testWidgets('should trigger stealth action when action button is pressed',
        (tester) async {
      // arrange
      final button = find.byKey(const Key('zodiac_action_button'));
      when(() => AuthenticationModulesMock.securityAction.start())
          .thenAnswer((_) => Future.value());
      when(() => AuthenticationModulesMock.securityAction.stop())
          .thenAnswer((_) => Future.value());
      await theAppIsRunning(tester, ZodiacPage(controller: controller));
      await tester.pumpAndSettle();
      // act
      await iSeeWidget(ZodiacActionButton);
      await tester.longPress(button);
      await tester.pumpAndSettle();
      // assert
      verify(() => AuthenticationModulesMock.securityAction.start()).called(1);
    });

    screenshotTestSimplified(
      'should render the page',
      fileName: 'zodiac_page',
      pageBuilder: () => ZodiacPage(controller: controller),
    );
  });
}
