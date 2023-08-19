import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/app_module.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/authentication/domain/repositories/i_authentication_repository.dart';
import 'package:penhas/app/features/authentication/domain/usecases/password_validator.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_in_module.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in_anonymous/sign_in_anonymous_page.dart';

import '../../../../../utils/golden_tests.dart';
import '../mocks/app_modules_mock.dart';
import '../mocks/authentication_modules_mock.dart';

// required IAuthenticationRepository repository,
// required LocalStore<UserProfileEntity> userProfileStore,
// required PasswordValidator passwordValidator,

void main() {
  setUp(() {
    AppModulesMock.init();
    AuthenticationModulesMock.init();

    initModules([
      AppModule(),
      SignInModule()
    ], replaceBinds: [
      Bind<IAuthenticationRepository>(
          (i) => AuthenticationModulesMock.authenticationRepository),
      Bind<PasswordValidator>(
          (i) => AuthenticationModulesMock.passwordValidator),
      Bind<LocalStore<UserProfileEntity>>(
          (i) => AppModulesMock.userProfileStore),
    ]);
  });

  tearDown(() {
    Modular.removeModule(SignInModule());
    Modular.removeModule(AppModule());
  });

  testWidgets('sign in anonymous page ...', (tester) async {
    // TODO: Implement test
  });

  group('golden test', () {
    setUp(() {
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
    });

    screenshotTest(
      'looks as expected',
      fileName: 'sign_in_anonymous_page',
      pageBuilder: _loadPage,
    );
  });
}

class MockModularNavigate extends Mock implements IModularNavigator {}

Widget _loadPage() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignInAnonymousPage(),
  );
}
