import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_test_steps.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  late String validPassword;
  late String validEmail;
  late SignInController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    validPassword = 'myStr0ngP4ssw0rd';
    validEmail = 'my@email.com';
    controller = SignInController(
        authenticateUserUseCase:
            AuthenticationModulesMock.authenticateUserUseCase,
        passwordValidator: AuthenticationModulesMock.passwordValidator,
        appStateUseCase: AppModulesMock.appStateUseCase);
  });

  group(SignInPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(
            tester,
            SignInPage(
              controller: controller,
            ));

        // check if necessary widgets are present
        await iSeeSingleTextInput(text: 'E-mail');
        await iSeePasswordField(text: 'Senha');
        await iSeeButton(text: 'Entrar');
        await iSeeButton(text: 'Esqueci minha senha');
        await iSeeButton(text: 'Termos de uso');
        await iSeeButton(text: 'Política de privacidade');
      },
    );

    testWidgets(
      'empty email and empty password show a message error',
      (tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        await theAppIsRunning(
            tester,
            SignInPage(
              controller: controller,
            ));
        await iDontSeeText(errorMessage);
        await iTapText(tester, text: 'Entrar');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'invalid email and valid password show a message error when tapping LoginButton',
      (tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => success(validPassword));

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iDontSeeText(errorMessage);
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'my_mail');
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'valid email and invalid password show a message error when tapping LoginButton',
      (tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => failure(EmptyRule()));

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iDontSeeText(errorMessage);
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: validEmail);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'displays error text for invalid email input',
      (tester) async {
        await theAppIsRunning(tester, SignInPage(controller: controller));
        // Update email with a invalid email
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'invalidEmail');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'E-mail', message: 'Endereço de email inválido');
      },
    );

    testWidgets(
      'shows an error for an invalid login',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => success(validPassword));

        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenFailure((i) => ServerFailure());

        when(
          () => AuthenticationModulesMock.authenticateUserUseCase(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenFailure((i) => ServerFailure());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iDontSeeText(errorMessage);
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: validEmail);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'deleted the account redirect page',
      (tester) async {
        const sessionToken = 'sessionToken';
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => success(validPassword));

        when(
          () => AuthenticationModulesMock.authenticateUserUseCase(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenSuccess((_) => const SessionEntity(
              sessionToken: sessionToken,
              deletedScheduled: true,
            ));

        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: validEmail);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');

        verify(() => AppModulesMock.modularNavigator.pushNamed(
              '/accountDeleted',
              arguments: sessionToken,
            )).called(1);
      },
    );

    testWidgets(
      'error trying redirect page',
      (tester) async {
        const sessionToken = 'sessionToken';
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => success(validPassword));

        when(
          () => AuthenticationModulesMock.authenticateUserUseCase(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenSuccess((_) => const SessionEntity(
              sessionToken: sessionToken,
              deletedScheduled: false,
            ));

        when(() => AppModulesMock.appStateUseCase.check())
            .thenFailure((i) => ServerFailure());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: validEmail);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');

        verifyNever(() => AppModulesMock.modularNavigator.pushNamed(
              '/accountDeleted',
              arguments: sessionToken,
            ));
      },
    );

    testWidgets(
      'success login redirect page',
      (tester) async {
        const sessionToken = 'sessionToken';
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((_) => success(validPassword));
        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenSuccess((_) => const SessionEntity(sessionToken: sessionToken));

        when(
          () => AuthenticationModulesMock.authenticateUserUseCase(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenSuccess((_) => const SessionEntity(sessionToken: sessionToken));

        when(() => AppModulesMock.appStateUseCase.check())
            .thenSuccess((_) => FakeAppStateEntity());

        when(
          () => AppModulesMock.modularNavigator
              .pushReplacementNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: validEmail);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');

        verify(() => AppModulesMock.modularNavigator.pushReplacementNamed(
            '/mainboard',
            arguments: {'page': 'feed'})).called(1);
      },
    );

    testWidgets(
      'sign-up redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iTapText(tester, text: 'Cadastrar');

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/signup')).called(1);
      },
    );

    testWidgets(
      'reset password redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iTapText(tester, text: 'Esqueci minha senha');

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/reset_password')).called(1);
      },
    );

    testWidgets(
      'terms of use redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        await iTapText(tester, text: 'Termos de uso');

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/terms_of_use')).called(1);
      },
    );

    testWidgets(
      'privacy policy redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, SignInPage(controller: controller));
        final expectedWidget = find.text('Política de privacidade');
        // Find the widget
        await tester.dragUntilVisible(
          expectedWidget,
          find.byType(SingleChildScrollView),
          const Offset(-250, 0),
        );
        // Tap the Privacy button
        await tester.tap(expectedWidget);
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/privacy_policy')).called(1);
      },
    );

    group(
      'golden tests',
      () {
        screenshotTest(
          'looks as expected',
          fileName: 'sign_in_page',
          pageBuilder: () => SignInPage(controller: controller),
        );
      },
    );
  });
}
