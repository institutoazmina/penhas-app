import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/presentation/deleted_account/deleted_account_page.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/modules_mock.dart';

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
    // testWidgets('deleted account page ...', (tester) async {});

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
