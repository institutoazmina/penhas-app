import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_test_steps.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  late SignInAnonymousController controller;
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
      badges: [],
    );

    when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
      (i) async => userProfileEntity,
    );

    controller = SignInAnonymousController(
      authenticateAnonymousUserUseCase:
          AuthenticationModulesMock.authenticateAnonymousUserUseCase,
      passwordValidator: AuthenticationModulesMock.passwordValidator,
      userProfileStore: AppModulesMock.userProfileStore,
    );
  });

  group(SignInAnonymousPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(
            tester,
            SignInAnonymousPage(
              controller: controller,
            ));

        // check if necessary widgets are present
        await iSeePasswordField(text: 'Senha');
        await iSeeButton(text: 'Entrar');
        await iSeeButton(text: 'Esqueci minha senha');
        await iSeeButton(text: 'Acessar outra conta');
      },
    );

    testWidgets(
      'invalid password shows a message error when tapping LoginButton',
      (tester) async {
        const validPassword = 'myStr0ngP4ssw0rd';
        const errorMessage =
            'E-mail e senha precisam estarem corretos para continuar.';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => failure(EmptyRule()));

        await theAppIsRunning(
            tester,
            SignInAnonymousPage(
              controller: controller,
            ));
        await iDontSeeText(errorMessage);
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'success login redirect page',
      (tester) async {
        const sessionToken = 'sessionToken';
        const validPassword = 'myStr0ngP4ssw0rd';

        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => success(validPassword));
        when(
          () => AuthenticationModulesMock.authenticationRepository
              .signInWithEmailAndPassword(
            emailAddress: any(named: 'emailAddress'),
            password: any(named: 'password'),
          ),
        ).thenSuccess((_) => const SessionEntity(sessionToken: sessionToken));

        when(
          () => AuthenticationModulesMock.authenticateAnonymousUserUseCase(
              email: any(named: 'email'), password: any(named: 'password')),
        ).thenSuccess((_) => const SessionEntity(
              sessionToken: sessionToken,
            ));

        when(() => AppModulesMock.appStateUseCase.check())
            .thenSuccess((_) => FakeAppStateEntity());
        when(
          () => AppModulesMock.modularNavigator
              .pushReplacementNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(
            tester,
            SignInAnonymousPage(
              controller: controller,
            ));
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: validPassword);
        await iTapText(tester, text: 'Entrar');

        verify(() => AppModulesMock.modularNavigator
            .pushReplacementNamed('/mainboard')).called(1);
      },
    );

    testWidgets(
      'reset password button redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(
            tester,
            SignInAnonymousPage(
              controller: controller,
            ));
        await iTapText(tester, text: 'Esqueci minha senha');

        verify(() => AppModulesMock.modularNavigator
            .pushNamed('/authentication/reset_password')).called(1);
      },
    );

    testWidgets(
      'change account button redirect page',
      (tester) async {
        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(
            tester,
            SignInAnonymousPage(
              controller: controller,
            ));
        await iTapText(tester, text: 'Acessar outra conta');

        verify(() =>
                AppModulesMock.modularNavigator.pushNamed('/authentication'))
            .called(1);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'sign_in_anonymous_page',
        pageBuilder: () => SignInAnonymousPage(
          controller: controller,
        ),
      );
    });
  });
}
