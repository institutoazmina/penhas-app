import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/login_button.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  late String validPassword;
  late String validEmail;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    validPassword = 'myStr0ngP4ssw0rd';
    validEmail = 'my@email.com';

    initModules([
      AppModule(),
      SignInModule()
    ], replaceBinds: [
      Bind<IAuthenticationRepository>(
          (i) => AuthenticationModulesMock.authenticationRepository),
      Bind<PasswordValidator>(
          (i) => AuthenticationModulesMock.passwordValidator),
      Bind<AppStateUseCase>((i) => AppModulesMock.appStateUseCase),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
    Modular.removeModule(AppModule());
  });

  group(SignInPage, () {
    testWidgets(
      'show screen widgets',
      (WidgetTester tester) async {
        await tester.pumpWidget(_loadSignInPage());

        // check if necessary widgets are present
        expect(find.text('E-mail'), findsOneWidget);
        expect(find.text('Senha'), findsOneWidget);
        expect(find.text('Esqueci minha senha'), findsOneWidget);
        expect(find.text('Termos de uso'), findsOneWidget);
        expect(find.text('Política de privacidade'), findsOneWidget);
      },
    );

    testWidgets(
      'empty email and empty password show a message error',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';
        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'invalid email and valid password show a message error when tap LoginButton',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => dartz.right(validPassword));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), 'my_mail');
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'valid email and invalid password show a message error when tap LoginButton',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => dartz.left(EmptyRule()));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'displays error text for invalid email input',
      (WidgetTester tester) async {
        await tester.pumpWidget(_loadSignInPage());

        // Update email with a invalid email
        await tester.enterText(find.byType(SingleTextInput), 'invalidEmail');
        await tester.pump();

        // Fetching the TextField's
        TextField textField = tester
            .widget(find.byKey(const Key('singleTextInput'))) as TextField;
        InputDecoration? decoration = textField.decoration;
        expect(decoration?.errorText, 'Endereço de email inválido');
      },
    );

    testWidgets(
      'show error for invalid login',
      (WidgetTester tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => dartz.right(validPassword));
        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((i) async => dartz.left(ServerFailure()));

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'deleted account redirect page',
      (WidgetTester tester) async {
        const sessionToken = 'sessionToken';
        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => dartz.right(validPassword));
        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (i) async => dartz.right(const SessionEntity(
              sessionToken: sessionToken, deletedScheduled: true)),
        );
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator.pushNamed(
              '/accountDeleted',
              arguments: sessionToken,
            )).called(1);
      },
    );

    testWidgets(
      'success login redirect page',
      (WidgetTester tester) async {
        const sessionToken = 'sessionToken';
        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => dartz.right(validPassword));
        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (i) async =>
              dartz.right(const SessionEntity(sessionToken: sessionToken)),
        );
        when(() => AppModulesMock.appStateUseCase.check())
            .thenAnswer((i) async => dartz.right(FakeAppStateEntity()));

        when(
          () => AppModulesMock.modularNavigator
              .popAndPushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the LoginButton
        await tester.enterText(find.byType(SingleTextInput), validEmail);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
                .popAndPushNamed('/mainboard', arguments: {'page': 'feed'}))
            .called(1);
      },
    );

    testWidgets(
      'sign up redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the sign up button
        await tester.tap(find.text('Cadastrar'));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/signup')).called(1);
      },
    );

    testWidgets(
      'reset password redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the Reset password button
        await tester.tap(find.text('Esqueci minha senha'));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/reset_password')).called(1);
      },
    );

    testWidgets(
      'terms of use redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());

        // Tap the Terms of use button
        await tester.tap(find.text('Termos de uso'));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/terms_of_use')).called(1);
      },
    );

    testWidgets(
      'privacy policy redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadSignInPage());
        final expectedWidget = find.text('Política de privacidade');

        // Tap the Privacy button
        await tester.dragUntilVisible(
          expectedWidget,
          find.byType(SingleChildScrollView),
          const Offset(-250, 0),
        );

        await tester.tap(expectedWidget);
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/privacy_policy')).called(1);
      },
    );

    group('golden tests', () {
      screenshotTest(
        'looks as expected',
        fileName: 'sign_in_page',
        pageBuilder: _loadSignInPage,
      );
    });
  });
}

Widget _loadSignInPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SignInPage(),
    ),
  );
}
