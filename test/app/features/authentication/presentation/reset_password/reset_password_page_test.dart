import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  setUp(() {
    AuthenticationModulesMock.init();
  });

  initModule(
    SignInModule(),
    replaceBinds: [
      Bind<IResetPasswordRepository>(
        (i) => AuthenticationModulesMock.resetPasswordRepository,
      ),
    ],
  );

  group(ResetPasswordPage, () {
    testWidgets(
      'displays error text for invalid email input',
      (tester) async {
        await tester.pumpWidget(_loadPage());

        // Update email with a invalid email
        await tester.enterText(find.byType(SingleTextInput), 'invalidEmail');
        await tester.pump();

        // Fetching the TextField's
        TextField textField = tester
            .widget(find.byKey(const Key('singleTextInput'))) as TextField;
        InputDecoration? decoration = textField.decoration;
        expect(decoration?.errorText, 'Endereço de email inválido');
      },
    );

    group('golden test', () {
      screenshotTest(
        'looks as expected',
        fileName: 'reset_password_page',
        pageBuilder: _loadPage,
      );
    });
  });
}

class MockModularNavigate extends Mock implements IModularNavigator {}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ResetPasswordPage(),
  );
}
