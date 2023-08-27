import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/pages/sign_up_three/sign_up_three_page.dart';

import '../../../../../../../../utils/golden_tests.dart';
import '../../../../mocks/app_modules_mock.dart';
import '../../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userFormField;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userFormField = UserRegisterFormFieldModel();

    initModule(SignInModule(), replaceBinds: [
      Bind<SignUpThreeController>(
        (i) => SignUpThreeController(
          AuthenticationModulesMock.userRegisterRepository,
          userFormField,
          AuthenticationModulesMock.passwordValidator,
        ),
      ),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

  group(SignUpThreePage, () {
    screenshotTest(
      'looks as expected',
      fileName: 'sign_up_step_3_page',
      pageBuilder: () => const SignUpThreePage(),
    );
  });
}
