import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/presentation/deleted_account/deleted_account_page.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';

class MockModularNavigate extends Mock implements IModularNavigator {}

void main() {
  late IModularNavigator modularNavigator;

  setUp(() {
    AppModulesMock.init();
    modularNavigator = MockModularNavigate();
    Modular.navigatorDelegate = modularNavigator;

    initModule(AppModule(), replaceBinds: [
      Bind<IAppConfiguration>((i) => AppModulesMock.appConfiguration),
      Bind<IUserProfileRepository>((i) => AppModulesMock.userProfileRepository),
    ]);
  });

  tearDown(() {
    Modular.removeModule(AppModule());
  });

  group(DeletedAccountPage, () {
    testWidgets(
      'show error message when failure to recovery the account',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(
          () => AppModulesMock.userProfileRepository
              .reactivate(token: any(named: 'token')),
        ).thenAnswer((i) async => dartz.left(ServerFailure()));
        await tester.pumpWidget(_loadPage());

        // Tap the button
        await tester.tap(find.text('Reativar Conta'));
        await tester.pump();
        expect(find.text(errorMessage), findsOneWidget);
      },
    );

    testWidgets(
      'redirect to successfully recovered account',
      (tester) async {
        when(
          () => AppModulesMock.userProfileRepository
              .reactivate(token: any(named: 'token')),
        ).thenAnswer((i) async => dartz.right(const ValidField()));
        when(
          () => AppModulesMock.appConfiguration
              .saveApiToken(token: any(named: 'token')),
        ).thenAnswer((i) => Future.value());
        when(
          () => modularNavigator.pushReplacementNamed(any()),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadPage());

        // Tap the button
        await tester.tap(find.text('Reativar Conta'));
        await tester.pump();

        verify(() => modularNavigator.pushReplacementNamed('/')).called(1);
      },
    );

    group('golden tests', () {
      screenshotTest(
        'looks as expected',
        fileName: 'deleted_account_page',
        pageBuilder: _loadPage,
      );
    });
  });
}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DeletedAccountPage(),
  );
}
