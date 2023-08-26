import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/widget_test_steps.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    initModule(
      SignInModule(),
      replaceBinds: [
        Bind<ResetPasswordController>(
          (i) => ResetPasswordController(
              AuthenticationModulesMock.resetPasswordRepository),
        ),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(ResetPasswordPage, () {
    testWidgets('shows screen widgets', (tester) async {
      await theAppIsRunning(tester, const ResetPasswordPage());
      await iSeeText('Esqueceu a senha?');
      await iSeeText(
          'Informe o seu e-mail para receber o código de recuperação de senha.');
      await iSeeSingleTextInput(text: 'E-mail');
      await iSeeButton(text: 'Próximo');
    });
    testWidgets(
      'displays error text for invalid email input',
      (tester) async {
        await theAppIsRunning(tester, const ResetPasswordPage());
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'invalidEmail');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'E-mail', message: 'Endereço de email inválido');
      },
    );

    testWidgets(
      'do not forward for invalid email',
      (tester) async {
        await theAppIsRunning(tester, const ResetPasswordPage());
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'invalidEmail');
        await iTapText(tester, text: 'Próximo');
        iSeeSingleTextInputErrorMessage(tester,
            text: 'E-mail', message: 'Endereço de email inválido');
      },
    );

    testWidgets(
      'shows error for authentication validation error',
      (WidgetTester tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => AuthenticationModulesMock.resetPasswordRepository
                .request(emailAddress: any(named: 'emailAddress')))
            .thenAnswer((i) async => dartz.left(ServerFailure()));

        await theAppIsRunning(tester, const ResetPasswordPage());
        await iDontSeeText(errorMessage);
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'valid@email.com');
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'forward for valid email',
      (WidgetTester tester) async {
        when(() => AuthenticationModulesMock.resetPasswordRepository
                .request(emailAddress: any(named: 'emailAddress')))
            .thenAnswer(
                (i) async => dartz.right(FakeResetPasswordResponseEntity()));
        when(() => AppModulesMock.modularNavigator
                .pushNamed(any(), arguments: any(named: 'arguments')))
            .thenAnswer((i) => Future.value());

        await theAppIsRunning(tester, const ResetPasswordPage());
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'valid@email.com');
        await iTapText(tester, text: 'Próximo');

        verify(() => AppModulesMock.modularNavigator.pushNamed(
            '/authentication/reset_password/step2',
            arguments: any(named: 'arguments'))).called(1);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_1',
        pageBuilder: () => const ResetPasswordPage(),
      );
    });
  });
}

class FakeResetPasswordResponseEntity extends Fake
    implements ResetPasswordResponseEntity {}
