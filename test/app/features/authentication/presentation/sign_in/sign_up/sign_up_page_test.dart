import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_page.dart';

import '../../../../../../utils/golden_tests.dart';
import '../../mocks/app_modules_mock.dart';
import '../../mocks/authentication_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

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
      screenshotTest(
        'looks as expected',
        fileName: 'sign_up_step_1_page',
        pageBuilder: () => const SignUpPage(),
      );
    },
  );
}
