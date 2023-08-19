import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_reset_password_repository.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/reset_password_page.dart';
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
    testWidgets('ResetPasswordPage has title', (tester) async {
      //  await tester.pumpWidget(buildTestableWidget(ResetPasswordPage(title: 'ResetPassword')));
      //  final titleFinder = find.text('ResetPassword');
      //  expect(titleFinder, findsOneWidget);
    });

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
