import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/extension/either.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/domain/entities/session_entity.dart';
import 'package:penhas/app/features/authentication/domain/usecases/authenticate_user.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_test_steps.dart';
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

    when(() => AuthenticationModulesMock.securityAction.isRunning)
        .thenAnswer((i) => Stream<bool>.value(false));

    when(() => AuthenticationModulesMock.securityAction.dispose())
        .thenAnswer((i) => Future.value());

    initModule(SignInModule(), replaceBinds: [
      Bind<SignInStealthController>(
        (i) => SignInStealthController(
          authenticateStealthUserUseCase:
              AuthenticationModulesMock.authenticateStealthUserUseCase,
          passwordValidator: AuthenticationModulesMock.passwordValidator,
          userProfileStore: AppModulesMock.userProfileStore,
          securityAction: AuthenticationModulesMock.securityAction,
        ),
      ),
      Bind<AuthenticateStealthUserUseCase>((i) =>
          AuthenticateStealthUserUseCase(
              authenticationRepository: i.get(),
              loginOfflineToggleFeature: i.get())),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });
  group(
    SignInStealthPage,
    () {
      testWidgets(
        'shows screen widgets',
        (tester) async {
          await theAppIsRunning(tester, const SignInStealthPage());

          await iSeePasswordField(text: 'Senha');
          await iSeeButton(text: 'Entrar');
          await iSeeButton(text: 'Esqueci minha senha');
          await iSeeButton(text: 'Acessar outra conta');
        },
      );

      testWidgets(
        'shows an error for invalid password',
        (tester) async {
          when(() => AuthenticationModulesMock.passwordValidator
              .validate(any(), any())).thenAnswer((_) => failure(EmptyRule()));

          await theAppIsRunning(tester, const SignInStealthPage());
          await iTapText(tester, text: 'Entrar');
          await iSeeText(
              'E-mail e senha precisam estarem corretos para continuar.');
        },
      );

      testWidgets(
        'shows an error for server-side password',
        (tester) async {
          const password = 'P4ssw0rd';
          when(() => AuthenticationModulesMock.passwordValidator
              .validate(any(), any())).thenAnswer((_) => success(password));
          when(
            () => AuthenticationModulesMock.authenticationRepository
                .signInWithEmailAndPassword(
                    emailAddress: any(named: 'emailAddress'),
                    password: any(named: 'password')),
          ).thenFailure((_) => ServerFailure());

          when(
            () => AuthenticationModulesMock.authenticateStealthUserUseCase(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenFailure((i) => ServerFailure());

          await theAppIsRunning(tester, const SignInStealthPage());

          await iEnterIntoPasswordField(tester,
              text: 'Senha', password: password);
          await iTapText(tester, text: 'Entrar');

          await iSeeText(
              'O servidor está com problema neste momento, tente novamente.');
        },
      );

      testWidgets(
        'valid password login into app',
        (tester) async {
          const sessionToken = 'sessionToken';
          const password = 'P4ssw0rd';
          when(() => AuthenticationModulesMock.passwordValidator
              .validate(any(), any())).thenAnswer((_) => success(password));
          when(
            () => AuthenticationModulesMock.authenticationRepository
                .signInWithEmailAndPassword(
                    emailAddress: any(named: 'emailAddress'),
                    password: any(named: 'password')),
          ).thenSuccess((_) => FakeSessionEntity());
          when(() => AppModulesMock.modularNavigator.canPop()).thenReturn(true);

          when(
            () => AuthenticationModulesMock.authenticateStealthUserUseCase(
                email: any(named: 'email'), password: any(named: 'password')),
          ).thenSuccess((_) => const SessionEntity(
                sessionToken: sessionToken,
              ));

          await theAppIsRunning(tester, const SignInStealthPage());

          await iEnterIntoPasswordField(tester,
              text: 'Senha', password: password);
          await iTapText(tester, text: 'Entrar');

          verify(() => AppModulesMock.modularNavigator.canPop()).called(1);
        },
      );

      testWidgets(
        'forward to forget my password',
        (tester) async {
          when(() => AppModulesMock.modularNavigator.pushNamed(any()))
              .thenAnswer((_) => Future.value());

          await theAppIsRunning(tester, const SignInStealthPage());
          await iTapText(tester, text: 'Esqueci minha senha');

          verify(() => AppModulesMock.modularNavigator
              .pushNamed('/authentication/reset_password')).called(1);
        },
      );

      testWidgets(
        'forward to changed account',
        (tester) async {
          when(() => AppModulesMock.modularNavigator.pushNamed(any()))
              .thenAnswer((_) => Future.value());

          await theAppIsRunning(tester, const SignInStealthPage());
          await iTapText(tester, text: 'Acessar outra conta');

          verify(() =>
                  AppModulesMock.modularNavigator.pushNamed('/authentication'))
              .called(1);
        },
      );

      group(
        'golden test',
        () {
          screenshotTest(
            'looks as expected',
            fileName: 'sign_in_stealth_page',
            pageBuilder: () => const SignInStealthPage(),
          );
        },
      );
    },
  );
}

class FakeSessionEntity extends Fake implements SessionEntity {}
