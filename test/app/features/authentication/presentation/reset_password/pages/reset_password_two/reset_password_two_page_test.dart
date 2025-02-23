import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/email_address.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../../../../../utils/mocktail_extension.dart';
import '../../../../../../../utils/widget_test_steps.dart';
import '../../../mocks/app_modules_mock.dart';
import '../../../mocks/authentication_modules_mock.dart';

class FakeEmailAddress extends Fake implements EmailAddress {}

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;
  late Key tokenInputKey;
  late ResetPasswordTwoController controller;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel()
      ..emailAddress = EmailAddress('email@email.com')
      ..token = 'token';

    tokenInputKey = const Key('reset_password_token');

    controller = ResetPasswordTwoController(
      AuthenticationModulesMock.changePasswordRepository,
      userRegisterFormField,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeEmailAddress());
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(ResetPasswordTwoPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(
            tester,
            ResetPasswordTwoPage(
              controller: controller,
            ));
        await iSeeText('Verifique seu e-mail');
        await iSeeText(
            'Por favor, digite o código de verificação que enviamos para o e-mail de recuperação.');
        await iSeeWidget(TextFormField, key: tokenInputKey);
        await iSeeButton(text: 'Próximo');
      },
    );
    testWidgets(
      'shows an error for an empty token when tapping the button',
      (tester) async {
        const errorMessage = 'Precisa digitar o código enviado';

        await theAppIsRunning(
            tester,
            ResetPasswordTwoPage(
              controller: controller,
            ));
        await iDontSeeText(errorMessage);
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'shows an error for server-side error',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(
          () => AuthenticationModulesMock.changePasswordRepository.validToken(
            emailAddress: any(named: 'emailAddress'),
            resetToken: any(named: 'resetToken'),
          ),
        ).thenFailure((_) => ServerFailure());

        await theAppIsRunning(
            tester,
            ResetPasswordTwoPage(
              controller: controller,
            ));
        await iDontSeeText(errorMessage);
        await iEnterIntoWidgetInput(tester,
            type: TextFormField, key: tokenInputKey, value: '123456');
        await iTapText(tester, text: 'Próximo');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'forward to the next step for a valid token',
      (tester) async {
        when(
          () => AuthenticationModulesMock.changePasswordRepository.validToken(
            emailAddress: any(named: 'emailAddress'),
            resetToken: any(named: 'resetToken'),
          ),
        ).thenSuccess((_) => const ValidField());

        when(
          () => AppModulesMock.modularNavigator
              .pushNamed(any(), arguments: any(named: 'arguments')),
        ).thenAnswer((i) => Future.value());

        await theAppIsRunning(
            tester,
            ResetPasswordTwoPage(
              controller: controller,
            ));
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
        pageBuilder: () => ResetPasswordTwoPage(
          controller: controller,
        ),
      );
    });
  });
}
