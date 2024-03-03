import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/splash/splash_controller.dart';
import 'package:penhas/app/features/splash/splash_module.dart';
import 'package:penhas/app/features/splash/splash_page.dart';

import '../../../utils/mocktail_extension.dart';
import '../../../utils/widget_test_steps.dart';
import '../authentication/presentation/mocks/app_modules_mock.dart';

void main() {
  setUp(() {
    AppModulesMock.init();

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

            when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
              (_) async => FakeUserProfileEntity.stealth(),
            );

            when(() =>
                    AppModulesMock.modularNavigator.pushReplacementNamed(any()))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                .pushReplacementNamed('/authentication/stealth')).called(1);
          },
        );

        testWidgets(
          'for unmapped error and in anonymous mode forward to `anonymousModeEnabled`',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);

            when(() => AppModulesMock.appStateUseCase.check())
                .thenFailure((_) => ServerFailure());

            when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
              (_) async => FakeUserProfileEntity.anonymous(),
            );

            when(() =>
                    AppModulesMock.modularNavigator.pushReplacementNamed(any()))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                    .pushReplacementNamed('/authentication/sign_in_stealth'))
                .called(1);
          },
        );

        testWidgets(
          'for unmapped error and not in security mode forward to `feed`',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);

            when(() => AppModulesMock.appStateUseCase.check())
                .thenFailure((_) => ServerFailure());

            when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
              (_) async => FakeUserProfileEntity(),
            );

            when(() => AppModulesMock.modularNavigator
                    .popAndPushNamed(any(), arguments: any(named: 'arguments')))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                    .popAndPushNamed('/mainboard', arguments: {'page': 'feed'}))
                .called(1);
          },
        );

        testWidgets(
          'goes to a quiz session for a pending quiz',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);

            when(() => AppModulesMock.appStateUseCase.check())
                .thenSuccess((_) => FakeAppStateEntity.quiz());

            when(() => AppModulesMock.modularNavigator
                    .popAndPushNamed(any(), arguments: any(named: 'arguments')))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(
              () => AppModulesMock.modularNavigator.popAndPushNamed(
                '/quiz?origin=splash',
                arguments: any(named: 'arguments'),
              ),
            ).called(1);
          },
        );
        testWidgets(
          'and not in security mode forward to `feed`',
          (tester) async {
            when(() => AppModulesMock.appConfiguration.authorizationStatus)
                .thenAnswer((i) async => AuthorizationStatus.authenticated);

            when(() => AppModulesMock.appStateUseCase.check())
                .thenSuccess((_) => FakeAppStateEntity());

            when(() => AppModulesMock.userProfileStore.retrieve()).thenAnswer(
              (_) async => FakeUserProfileEntity(),
            );

            when(() => AppModulesMock.modularNavigator
                    .popAndPushNamed(any(), arguments: any(named: 'arguments')))
                .thenAnswer((i) => Future.value());

            await theAppIsRunning(tester, const SplashPage());
            verify(() => AppModulesMock.modularNavigator
                    .popAndPushNamed('/mainboard', arguments: {'page': 'feed'}))
                .called(1);
          },
        );
      });
    },
  );
}

class FakeUserProfileEntity extends Fake implements UserProfileEntity {
  FakeUserProfileEntity({
    bool stealthModeEnabled = false,
    bool anonymousModeEnabled = false,
  })  : _stealthModeEnabled = stealthModeEnabled,
        _anonymousModeEnabled = anonymousModeEnabled;

  factory FakeUserProfileEntity.stealth() {
    return FakeUserProfileEntity(stealthModeEnabled: true);
  }

  factory FakeUserProfileEntity.anonymous() =>
      FakeUserProfileEntity(anonymousModeEnabled: true);

  final bool _stealthModeEnabled;
  final bool _anonymousModeEnabled;

  @override
  bool get stealthModeEnabled => _stealthModeEnabled;

  @override
  bool get anonymousModeEnabled => _anonymousModeEnabled;
}

class FakeQuizSessionEntity extends Fake implements QuizSessionEntity {
  @override
  bool get isFinished => false;
}

class FakeAppStateEntity extends Fake implements AppStateEntity {
  FakeAppStateEntity({QuizSessionEntity? quizSessionEntity})
      : _quizSessionEntity = quizSessionEntity;

  factory FakeAppStateEntity.quiz() =>
      FakeAppStateEntity(quizSessionEntity: FakeQuizSessionEntity());

  final QuizSessionEntity? _quizSessionEntity;

  @override
  QuizSessionEntity? get quizSession => _quizSessionEntity;
}
