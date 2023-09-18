import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/features/splash/splash_module.dart';
import 'package:penhas/app/features/splash/splash_page.dart';

import '../../../utils/mocktail_extension.dart';
import '../../../utils/widget_test_steps.dart';
import '../authentication/presentation/mocks/app_modules_mock.dart';

void main() {
  late UserProfileEntity userProfileEntity;

  setUp(() {
    AppModulesMock.init();
    userProfileEntity = UserProfileEntity(
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

    initModule(
      SplashModule(),
      replaceBinds: [
        Bind<SplashController>(
          (i) => SplashController(
            appConfiguration: AppModulesMock.appConfiguration,
            appStateUseCase: AppModulesMock.appStateUseCase,
            userProfileStore: AppModulesMock.userProfileStore,
          ),
        ),
      ],
    );
  });

  tearDown(() {
    Modular.removeModule(SplashModule());
  });

  group(
    SplashPage,
    () {
      testWidgets(
        'in anonymous states forward to `authentication`',
        (tester) async {
          when(() => AppModulesMock.appConfiguration.authorizationStatus)
              .thenAnswer((i) async => AuthorizationStatus.anonymous);
          when(() =>
                  AppModulesMock.modularNavigator.pushReplacementNamed(any()))
              .thenAnswer((i) => Future.value());

          await theAppIsRunning(tester, const SplashPage());
          verify(() => AppModulesMock.modularNavigator
              .pushReplacementNamed('/authentication')).called(1);
        },
      );

      group('in authenticated states', () {
        testWidgets(
          'with ServerSideSessionFailed forward to `authentication`',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);
            when(() => AppModulesMock.appStateUseCase.check())
                .thenFailure((_) => ServerSideSessionFailed());
            when(() =>
                    AppModulesMock.modularNavigator.pushReplacementNamed(any()))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                .pushReplacementNamed('/authentication')).called(1);
          },
        );
        testWidgets(
          'for unmapped error and in stealth mode forward to `stealthModeEnabled`',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);

            when(() => AppModulesMock.appStateUseCase.check())
                .thenFailure((_) => ServerFailure());

            when(() => AppModulesMock.userProfileStore.retrieve())
                .thenAnswer((_) async => userProfileEntity);

            when(() =>
                    AppModulesMock.modularNavigator.pushReplacementNamed(any()))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                .pushReplacementNamed('/authentication/stealth')).called(1);
          },
        );
      });
    },
  );
}
