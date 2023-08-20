import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/user_register_form_field_model.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../../../utils/golden_tests.dart';
import '../../../mocks/authentication_modules_mock.dart';

void main() {
  late UserRegisterFormFieldModel userRegisterFormField;

  setUp(() {
    AuthenticationModulesMock.init();
    userRegisterFormField = UserRegisterFormFieldModel();

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
    testWidgets(
      'show error for empty token when tap button',
      (tester) async {
        const errorMessage = 'Precisa digitar o código enviado';

        await tester.pumpWidget(_loadPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.tap(find.text('Próximo'));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page_step_2',
        pageBuilder: _loadPage,
      );
    });
  });
}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResetPasswordTwoPage(),
  );
}
