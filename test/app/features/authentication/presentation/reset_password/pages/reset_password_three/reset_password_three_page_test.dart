import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../../../../../utils/widget_test_steps.dart';
import '../../../mocks/app_modules_mock.dart';
import '../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel();
    userRegisterFormField.token = 'token';

    initModule(
      SignInModule(),
      replaceBinds: [
        Bind<ResetPasswordThreeController>(
          (i) => ResetPasswordThreeController(
            AuthenticationModulesMock.changePasswordRepository,
            userRegisterFormField,
            AuthenticationModulesMock.passwordValidator,
          ),
        ),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(ResetPasswordThreePage, () {
    testWidgets(
      'show screen widgets',
      (tester) async {
        await theAppIsRunning(tester, const ResetPasswordThreePage());

        // check that required widgets are present
        await iSeeText('Configure uma nova senha');
        await iSeeText('Crie uma senha diferente das anteriores');
        await iSeePasswordField(text: 'Senha');
        await iSeePasswordField(text: 'Confirmação de senha');
        await iSeeButton(text: 'Salvar');
      },
    );

    testWidgets(
      'invalid password shows hint message',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator.validate(
            any(), any())).thenAnswer((i) => dartz.left(MinLengthRule()));

        // Input a invalid password
        await theAppIsRunning(tester, const ResetPasswordThreePage());
        await iEnterIntoPasswordField(tester, text: 'Senha', password: '1');
        await iSeePasswordFieldErrorMessage(tester,
            text: 'Senha', message: 'Senha precisa ter no mínimo 8 caracteres');
      },
    );

    testWidgets(
      'show error message if password field and password confirmation field are different',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => dartz.right('password'));

        // Input a invalid password
        await theAppIsRunning(tester, const ResetPasswordThreePage());
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'p4ssw0rd');
        await iSeePasswordFieldErrorMessage(tester,
            text: 'Confirmação de senha', message: 'As senhas não são iguais');
      },
    );

    testWidgets(
      'show error mensagem form server side error when reset password',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => dartz.right('password'));

        when(() => AuthenticationModulesMock.changePasswordRepository.reset(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
              resetToken: any(named: 'resetToken'),
            )).thenAnswer((i) async => dartz.left(ServerFailure()));

        // Capture server side error message
        await theAppIsRunning(tester, const ResetPasswordThreePage());
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'password');
        await iTapText(tester, text: 'Salvar');
        await iSeeText(
            'O servidor está com problema neste momento, tente novamente.');
      },
    );

    testWidgets(
      'forward for a successfully password reset',
      (tester) async {
        when(() => AuthenticationModulesMock.passwordValidator
            .validate(any(), any())).thenAnswer((i) => dartz.right('password'));

        when(() => AuthenticationModulesMock.changePasswordRepository.reset(
              emailAddress: any(named: 'emailAddress'),
              password: any(named: 'password'),
              resetToken: any(named: 'resetToken'),
            )).thenAnswer((i) async => dartz.right(const ValidField()));

        when(() => AppModulesMock.modularNavigator.pushNamedAndRemoveUntil(
            any(), any())).thenAnswer((i) => Future.value());

        // Capture server side error message
        await theAppIsRunning(tester, const ResetPasswordThreePage());
        await iEnterIntoPasswordField(tester,
            text: 'Senha', password: 'password');
        await iEnterIntoPasswordField(tester,
            text: 'Confirmação de senha', password: 'password');
        await iTapText(tester, text: 'Salvar');

        verify(() => AppModulesMock.modularNavigator
            .pushNamedAndRemoveUntil('/authentication', any())).called(1);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_3',
        pageBuilder: () => const ResetPasswordThreePage(),
      );
    });
  });
}
