import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../../../../../utils/widget_test_steps.dart';
import '../../../mocks/app_modules_mock.dart';
import '../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;
  late Key tokenInputKey;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel();
    tokenInputKey = const Key('reset_password_token');

    initModule(
      SignInModule(),
      replaceBinds: [
        Bind<ResetPasswordTwoController>(
          (i) => ResetPasswordTwoController(
            AuthenticationModulesMock.changePasswordRepository,
            userRegisterFormField,
          ),
        ),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(ResetPasswordTwoPage, () {
    testWidgets('shows screen widgets', (tester) async {
      await theAppIsRunning(tester, const ResetPasswordTwoPage());
      await iSeeText('Verifique seu e-mail');
      await iSeeText(
          'Por favor, digite o código de verificação que enviamos para o e-mail de recuperação.');
      await iSeeWidget(TextFormField, key: tokenInputKey);
      await iSeeButton(text: 'Próximo');
    });
    testWidgets(
      'shows error for empty token when tap button',
      (tester) async {
        const errorMessage = 'Precisa digitar o código enviado';

        await theAppIsRunning(tester, const ResetPasswordTwoPage());
        await iDontSeeText(errorMessage);
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'shows error for server side error',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(
          () => AuthenticationModulesMock.changePasswordRepository.validToken(
            emailAddress: any(named: 'emailAddress'),
            resetToken: any(named: 'resetToken'),
          ),
        ).thenAnswer((i) async => dartz.left(ServerFailure()));

        await theAppIsRunning(tester, const ResetPasswordTwoPage());
        await iDontSeeText(errorMessage);
        await iEnterIntoWidgetInput(tester,
            type: TextFormField, key: tokenInputKey, value: '123456');
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'forward to next step for valid token',
      (tester) async {
        when(
          () => AuthenticationModulesMock.changePasswordRepository.validToken(
            emailAddress: any(named: 'emailAddress'),
            resetToken: any(named: 'resetToken'),
          ),
        ).thenAnswer((i) async => dartz.right(const ValidField()));

        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((i) => Future.value());

        await theAppIsRunning(tester, const ResetPasswordTwoPage());
        await iEnterIntoWidgetInput(tester,
            type: TextFormField, key: tokenInputKey, value: '123456');
        await iTapText(tester, text: 'Próximo');

        verify(() => AppModulesMock.modularNavigator.pushNamed(
            '/authentication/reset_password/step3',
            arguments: any(named: 'arguments'))).called(1);
      },
    );
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_2',
        pageBuilder: () => const ResetPasswordTwoPage(),
      );
    });
  });
}
