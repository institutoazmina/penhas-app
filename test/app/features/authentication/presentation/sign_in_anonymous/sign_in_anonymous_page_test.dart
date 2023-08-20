import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/login_button.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    final userProfileEntity = UserProfileEntity(
      fullName: 'fullName',
      nickname: 'nickname',
      email: 'email@testing.com',
      birthdate: DateTime(1970),
      genre: 'genre',
      minibio: 'minibio',
      race: 'race',
      avatar: 'avatar',
      skill: const ['skill1', 'skill2'],
      stealthModeEnabled: true,
      anonymousModeEnabled: true,
      jaFoiVitimaDeViolencia: false,
    );

    when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
      (i) async => userProfileEntity,
    );

    initModules([
      AppModule(),
      SignInModule()
    ], replaceBinds: [
      Bind<IAuthenticationRepository>(
          (i) => AuthenticationModulesMock.authenticationRepository),
      Bind<PasswordValidator>(
          (i) => AuthenticationModulesMock.passwordValidator),
      Bind<LocalStore<UserProfileEntity>>(
          (i) => AppModulesMock.userProfileStore),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
    Modular.removeModule(AppModule());
  });

  group(SignInAnonymousPage, () {
    testWidgets(
      'show screen widgets',
      (tester) async {
        await tester.pumpWidget(_loadPage());

        // check if necessary widgets are present
        expect(find.text('Senha'), findsOneWidget);
        expect(find.text('Entrar'), findsOneWidget);
        expect(find.text('Esqueci minha senha'), findsOneWidget);
        expect(find.text('Acessar outra conta'), findsOneWidget);
      },
    );

    testWidgets(
      'invalid password show a message error when tap LoginButton',
      (WidgetTester tester) async {
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => dartz.left(EmptyRule()));

        await tester.pumpWidget(_loadPage());
        const validPassword = 'myStr0ngP4ssw0rd';

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'success login redirect page',
      (WidgetTester tester) async {
        const sessionToken = 'sessionToken';
        const validPassword = 'myStr0ngP4ssw0rd';

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
              .pushReplacementNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadPage());

        // Tap the LoginButton
        await tester.enterText(find.byType(PassordInputField), validPassword);
        await tester.tap(find.byType(LoginButton));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushReplacementNamed('/mainboard')).called(1);
      },
    );

    testWidgets(
      'reset password redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadPage());

        // Tap the sign up button
        await tester.tap(find.text('Esqueci minha senha'));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/reset_password')).called(1);
      },
    );

    testWidgets(
      'change account redirect page',
      (WidgetTester tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadPage());

        // Tap the sign up button
        await tester.tap(find.text('Acessar outra conta'));
        await tester.pump();

        verify(() =>
                AppModulesMock.modularNavigator.pushNamed('/authentication'))
            .called(1);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'sign_in_anonymous_page',
        pageBuilder: _loadPage,
      );
    });
  });
}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignInAnonymousPage(),
  );
}
