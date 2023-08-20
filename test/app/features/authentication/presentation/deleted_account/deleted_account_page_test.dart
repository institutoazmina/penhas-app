import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/deleted_account/deleted_account_controller.dart';
import 'package:penhas/app/features/authentication/presentation/deleted_account/deleted_account_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();

    initModule(AppModule(), replaceBinds: [
      Bind<DeletedAccountController>(
        (i) => DeletedAccountController(
          profileRepository: AppModulesMock.userProfileRepository,
          appConfiguration: AppModulesMock.appConfiguration,
          sessionToken: '',
        ),
      ),
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
          () => AppModulesMock.modularNavigator.pushReplacementNamed(any()),
        ).thenAnswer((_) => Future.value());

        await tester.pumpWidget(_loadPage());

        // Tap the button
        await tester.tap(find.text('Reativar Conta'));
        await tester.pump();

        verify(() => AppModulesMock.modularNavigator.pushReplacementNamed('/'))
            .called(1);
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
