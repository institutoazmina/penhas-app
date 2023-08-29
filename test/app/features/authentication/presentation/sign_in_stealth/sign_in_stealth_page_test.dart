import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_controller.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_stealth/sign_in_stealth_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();
    final userProfileEntity = UserProfileEntity(
      fullName: 'fullName',
      nickname: 'nickname',
      email: 'email@testing.com',
      birthdate: DateTime(1970),
      genre: 'genre',
      minibio: 'minibio',
      race: 'race',
      avatar: 'avatar',
      skill: const ['skill1', 'skill2'],
      stealthModeEnabled: true,
      anonymousModeEnabled: true,
      jaFoiVitimaDeViolencia: false,
    );

    when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
      (i) async => userProfileEntity,
    );

    when(() => AuthenticationModulesMock.securityAction.isRunning)
        .thenAnswer((i) => Stream<bool>.value(false));

    when(() => AuthenticationModulesMock.securityAction.dispose())
        .thenAnswer((i) => Future.value());

    initModule(SignInModule(), replaceBinds: [
      Bind<SignInStealthController>(
        (i) => SignInStealthController(
          repository: AuthenticationModulesMock.authenticationRepository,
          userProfileStore: AppModulesMock.userProfileStore,
          securityAction: AuthenticationModulesMock.securityAction,
          passwordValidator: AuthenticationModulesMock.passwordValidator,
        ),
      ),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
  });
  group(
    SignInStealthPage,
    () {
      screenshotTest(
        'looks as expected',
        fileName: 'sign_in_stealth_page',
        pageBuilder: () => const SignInStealthPage(),
      );
    },
  );
}
