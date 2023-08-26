import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../../../../../utils/widget_test_steps.dart';
import '../../mocks/app_modules_mock.dart';
import '../../mocks/authentication_modules_mock.dart';

void main() {
  late Key cepKey;
  late Key cpfKey;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    cepKey = const Key('sign_up_cep');
    cpfKey = const Key('sign_up_cpf');

    initModule(SignInModule(), replaceBinds: [
      Bind<SignUpController>(
        (i) =>
            SignUpController(AuthenticationModulesMock.userRegisterRepository),
      ),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });
  group(
    SignUpPage,
    () {
      testWidgets(
        'show screen widgets',
        (tester) async {
          await theAppIsRunning(tester, const SignUpPage());
          await iSeeText('Crie sua conta');
          await iSeeText(
              'Para sua segurança pedimos aos nossos usuários o CPF.');
          await iSeeSingleTextInput(text: 'Nome completo');
          await iSeeSingleTextInput(text: 'Data de nascimento');
          await iSeeSingleTextInput(key: cpfKey);
          await iSeeSingleTextInput(key: cepKey);
          await iSeeButton(text: 'Não sei o meu CEP');
          await iSeeButton(text: 'Próximo');
        },
      );

      testWidgets('shows warning message on invalid widget value',
          (tester) async {
        await theAppIsRunning(tester, const SignUpPage());
        await iTapText(tester, text: 'Próximo');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'Nome completo', message: 'Nome inválido para o sistema');
        await iSeeSingleTextInputErrorMessage(tester,
            text: 'Data de nascimento', message: 'Data de nascimento inválida');
        await iSeeSingleTextInputErrorMessage(tester,
            key: cpfKey, message: 'CPF inválido');
        await iSeeSingleTextInputErrorMessage(tester,
            key: cepKey, message: 'CEP inválido');
      });

      screenshotTest(
        'looks as expected',
        fileName: 'sign_up_step_1_page',
        pageBuilder: () => const SignUpPage(),
      );
    },
  );
}
