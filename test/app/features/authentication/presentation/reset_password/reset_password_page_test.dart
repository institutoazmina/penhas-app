import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  late IModularNavigator modularNavigator;

  setUp(() {
    AuthenticationModulesMock.init();
    modularNavigator = MockModularNavigate();
    Modular.navigatorDelegate = modularNavigator;

    initModule(
      SignInModule(),
      replaceBinds: [
        Bind<IResetPasswordRepository>(
          (i) => AuthenticationModulesMock.resetPasswordRepository,
        ),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });

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

    testWidgets(
      'do not forward for invalid email',
      (tester) async {
        await tester.pumpWidget(_loadPage());
        await tester.tap(find.text('Próximo'));
        await tester.pump();

        // Fetching the TextField's
        TextField textField = tester
            .widget(find.byKey(const Key('singleTextInput'))) as TextField;
        InputDecoration? decoration = textField.decoration;
        expect(decoration?.errorText, 'Endereço de email inválido');
      },
    );

    testWidgets(
      'show error for authentication validation error',
      (WidgetTester tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(() => AuthenticationModulesMock.resetPasswordRepository
                .request(emailAddress: any(named: 'emailAddress')))
            .thenAnswer((i) async => dartz.left(ServerFailure()));

        await tester.pumpWidget(_loadPage());

        // Tap the LoginButton
        expect(find.text(errorMessage), findsNothing);
        await tester.enterText(find.byType(SingleTextInput), 'valid@email.com');
        await tester.tap(find.text('Próximo'));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
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
