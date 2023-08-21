import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_three/reset_password_three_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../mocks/app_modules_mock.dart';
import '../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;

  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel();

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

  group(ResetPasswordThreePage, () {
    testWidgets(
      'show screen widgets',
      (tester) async {
        await tester.pumpWidget(_loadPage());

        // check if necessary widgets are present
        expect(find.text('Senha'), findsOneWidget);
        expect(find.text('Confirmação de senha'), findsOneWidget);
        expect(find.text('Salvar'), findsOneWidget);
      },
    );
    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_3',
        pageBuilder: _loadPage,
      );
    });
  });
}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResetPasswordThreePage(),
  );
}
