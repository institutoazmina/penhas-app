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
import '../../../../../utils/mocktail_extension.dart';
import '../../../../../utils/widget_test_steps.dart';
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
      'shows screen widgets',
      (tester) async {
        await theAppIsRunning(tester, const DeletedAccountPage());
        await iSeeText('Deseja reativar?');
        await iSeeText(
            'Esta conta está marcada para ser excluída.\n\nVocê pode interromper este processo agora reativando a conta.');
        await iSeeButton(text: 'Reativar Conta');
      },
    );
    testWidgets(
      'shows an error message when failure to recover the account',
      (tester) async {
        const errorMessage =
            'O servidor está com problema neste momento, tente novamente.';

        when(
          () => AppModulesMock.userProfileRepository
              .reactivate(token: any(named: 'token')),
        ).thenFailure((_) => ServerFailure());

        await theAppIsRunning(tester, const DeletedAccountPage());
        await iTapText(tester, text: 'Reativar Conta');
        await iSeeText(errorMessage);
      },
    );

    testWidgets(
      'redirect to successfully recovered account',
      (tester) async {
        when(
          () => AppModulesMock.userProfileRepository
              .reactivate(token: any(named: 'token')),
        ).thenSuccess((_) => const ValidField());

        when(
          () => AppModulesMock.appConfiguration
              .saveApiToken(token: any(named: 'token')),
        ).thenAnswer((i) => Future.value());
        when(
          () => AppModulesMock.modularNavigator.pushReplacementNamed(any()),
        ).thenAnswer((_) => Future.value());

        await theAppIsRunning(tester, const DeletedAccountPage());
        await iTapText(tester, text: 'Reativar Conta');

        verify(() => AppModulesMock.modularNavigator.pushReplacementNamed('/'))
            .called(1);
      },
    );

    group('golden tests', () {
      screenshotTest(
        'looks as expected',
        fileName: 'deleted_account_page',
        pageBuilder: () => const DeletedAccountPage(),
      );
    });
  });
}
