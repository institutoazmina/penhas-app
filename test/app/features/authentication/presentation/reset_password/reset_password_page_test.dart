import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/entities/reset_password_response_entity.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_test_steps.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  late ResetPasswordController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    controller = ResetPasswordController(
        AuthenticationModulesMock.resetPasswordRepository);
  });

  group(ResetPasswordPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(
            tester, ResetPasswordPage(controller: controller));
        await iSeeText('Esqueceu a senha?');
        await iSeeText(
            'Informe o seu e-mail para receber o código de recuperação de senha.');
        await iSeeSingleTextInput(text: 'E-mail');
        await iSeeButton(text: 'Próximo');
      },
    );
    testWidgets(
      'displays error text for invalid email input',
      (tester) async {
        await theAppIsRunning(
            tester, ResetPasswordPage(controller: controller));
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'invalidEmail');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'E-mail', message: 'Endereço de email inválido');
      },
    );

    testWidgets(
      'do not forward for invalid email',
      (tester) async {
        await theAppIsRunning(
            tester, ResetPasswordPage(controller: controller));
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'invalidEmail');
        await iTapText(tester, text: 'Próximo');
        iSeeSingleTextInputErrorMessage(tester,
            text: 'E-mail', message: 'Endereço de email inválido');
      },
    );

    testWidgets(
      'shows an error for the authentication validation error',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => AuthenticationModulesMock.resetPasswordRepository
                .request(emailAddress: any(named: 'emailAddress')))
            .thenFailure((i) => ServerFailure());

        await theAppIsRunning(
            tester, ResetPasswordPage(controller: controller));
        await iDontSeeText(errorMessage);
        await iEnterIntoSingleTextInput(tester,
            text: 'E-mail', value: 'valid@email.com');
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'forward for valid email',
      (tester) async {
        when(() => AuthenticationModulesMock.resetPasswordRepository
                .request(emailAddress: any(named: 'emailAddress')))
            .thenSuccess((_) => FakeResetPasswordResponseEntity());

        when(() => AppModulesMock.modularNavigator
                .pushNamed(any(), arguments: any(named: 'arguments')))
            .thenAnswer((i) => Future.value());

        await theAppIsRunning(
            tester, ResetPasswordPage(controller: controller));
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
        pageBuilder: () => ResetPasswordPage(controller: controller),
      );
    });
  });
}

class FakeResetPasswordResponseEntity extends Fake
    implements ResetPasswordResponseEntity {}
