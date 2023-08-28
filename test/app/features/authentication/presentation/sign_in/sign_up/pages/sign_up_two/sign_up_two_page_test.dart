import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_two/sign_up_two_page.dart';

import '../../../../../../../../utils/golden_tests.dart';
import '../../../../../../../../utils/widget_test_steps.dart';
import '../../../../mocks/app_modules_mock.dart';
import '../../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userFormField;
  late Key genreDropdownList;
  late Key raceDropdownList;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userFormField = UserRegisterFormFieldModel();
    genreDropdownList = const Key('genreDropdownList');
    raceDropdownList = const Key('raceDropdownList');

    initModule(SignInModule(), replaceBinds: [
      Bind<SignUpTwoController>(
        (i) => SignUpTwoController(
            AuthenticationModulesMock.userRegisterRepository, userFormField),
      ),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(SignUpTwoPage, () {
    testWidgets(
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(tester, const SignUpTwoPage());

        // check if necessary widgets are present
        await iSeeText('Crie sua conta');
        await iSeeText('Nos conte um pouco mais sobre você.');
        await iSeeSingleTextInput(text: 'Apelido');
        await iSeeWidget(DropdownButtonFormField<String>,
            key: genreDropdownList);
        await iSeeWidget(DropdownButtonFormField<String>,
            key: raceDropdownList);
        await iSeeButton(text: 'Próximo');
      },
    );

    screenshotTest(
      'looks as expected',
      fileName: 'sign_up_step_2_page',
      pageBuilder: () => const SignUpTwoPage(),
    );
  });
}
