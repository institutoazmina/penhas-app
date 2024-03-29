import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_preferences_use_case.dart';
import 'package:penhas/app/shared/navigation/app_route.dart';

void main() {
  late InactivityLogoutUseCase useCase;
  late LocalStore<UserProfileEntity> userProfileStore;
  late LocalStore<AppPreferencesEntity> appPreferencesStore;

  setUpAll(() {
    registerFallbackValue(
      const AppPreferencesEntity(
        inactiveAppLogoutTimeInSeconds: 30,
        inactiveAppSince: null,
      ),
    );
  });

  setUp(() {
    appPreferencesStore = MockAppPreferencesStore();
    userProfileStore = MockUserProfileStore();
    useCase = InactivityLogoutUseCase(
      appPreferencesStore: appPreferencesStore,
      userProfileStore: userProfileStore,
    );
  });

  group('AppPreferencesUseCase#setActive', () {
    Future<void> _setActive({required DateTime? inactiveSince}) async {
      when(() => appPreferencesStore.retrieve()).thenAnswer(
        (_) async => AppPreferencesEntity(
          inactiveAppSince: inactiveSince?.millisecondsSinceEpoch,
          inactiveAppLogoutTimeInSeconds: 30,
        ),
      );

      when(() => appPreferencesStore.save(any()))
          .thenAnswer((_) => Future.value());

      return useCase.setActive();
    }

    test('clears inactive since to null when customer was inactive', () async {
      await _setActive(inactiveSince: DateTime.now());
      verify(
        () => appPreferencesStore.save(
          const AppPreferencesEntity(
            inactiveAppSince: null,
            inactiveAppLogoutTimeInSeconds: 30,
          ),
        ),
      );
    });

    test('keeps inactive since null when customer was active', () async {
      await _setActive(inactiveSince: null);
      verify(
        () => appPreferencesStore.save(
          const AppPreferencesEntity(
            inactiveAppSince: null,
            inactiveAppLogoutTimeInSeconds: 30,
          ),
        ),
      );
    });
  });

  group('AppPreferencesUseCase#setInactivity', () {
    Future<void> _setInactivity({
      required DateTime now,
      required DateTime? previousInactivity,
    }) async {
      when(() => appPreferencesStore.retrieve()).thenAnswer(
        (_) async => AppPreferencesEntity(
          inactiveAppSince: previousInactivity?.millisecondsSinceEpoch,
          inactiveAppLogoutTimeInSeconds: 30,
        ),
      );

      when(() => appPreferencesStore.save(any()))
          .thenAnswer((_) => Future.value());
      return useCase.setInactive(now);
    }

    final now = DateTime.now();

    test('customer was not inactive then save inactivity time', () async {
      await _setInactivity(now: now, previousInactivity: null);
      verify(
        () => appPreferencesStore.save(
          AppPreferencesEntity(
            inactiveAppSince: now.millisecondsSinceEpoch,
            inactiveAppLogoutTimeInSeconds: 30,
          ),
        ),
      );
    });

    test('customer was inactive then save new inactivity time', () async {
      await _setInactivity(
        now: now,
        previousInactivity: now.subtract(const Duration(hours: 1)),
      );
      verify(
        () => appPreferencesStore.save(
          AppPreferencesEntity(
            inactiveAppSince: now.millisecondsSinceEpoch,
            inactiveAppLogoutTimeInSeconds: 30,
          ),
        ),
      );
    });
  });

  group('AppPreferencesUseCase#inactivityRoute', () {
    Future<Either<InactivityError?, AppRoute?>> _inactivityRoute({
      required DateTime? inactiveSince,
      required DateTime now,
      required bool stealthModeEnabled,
      required bool anonymousModeEnabled,
    }) async {
      when(() => appPreferencesStore.retrieve()).thenAnswer(
        (_) async => AppPreferencesEntity(
          inactiveAppSince: inactiveSince?.millisecondsSinceEpoch,
          inactiveAppLogoutTimeInSeconds: 30,
        ),
      );
      when(() => userProfileStore.retrieve()).thenAnswer(
        (_) async => UserProfileModel(
          stealthModeEnabled: stealthModeEnabled,
          anonymousModeEnabled: anonymousModeEnabled,
          birthdate: DateTime.now(),
        ),
      );

      return useCase.inactivityRoute(now);
    }

    final now = DateTime.now();

    test(
        'inactivity returns stealth authentication route when customer is inactive for 30 seconds and is in stealth mode',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: true,
        anonymousModeEnabled: false,
      );

      expect(value.isRight(), true);
      expect(
        value.fold((l) => l, (r) => r),
        AppRoute('/authentication/stealth'),
      );
    });

    test(
        'inactivity returns stealth authentication route when customer is inactive for 31 seconds and is in stealth mode',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: true,
        anonymousModeEnabled: false,
      );

      expect(value.isRight(), true);
      expect(
        value.fold((l) => l, (r) => r),
        AppRoute('/authentication/stealth'),
      );
    });

    test(
        'inactivity returns stealth authentication route when customer is inactive for 30 seconds and is in stealth mode',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: true,
        anonymousModeEnabled: false,
      );

      expect(value.isRight(), true);
      expect(
        value.fold((l) => l, (r) => r),
        AppRoute('/authentication/stealth'),
      );
    });

    test(
        'inactivity returns stealth sign in route when customer is inactive for 30 seconds and is in anonymous mode',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: false,
        anonymousModeEnabled: true,
      );

      expect(value.isRight(), true);
      expect(
        value.fold((l) => l, (r) => r),
        AppRoute('/authentication/sign_in_stealth'),
      );
    });

    test(
        'inactivity returns stealth sign in route when customer is inactive for 31 seconds and is in anonymous mode',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: false,
        anonymousModeEnabled: true,
      );

      expect(value.isRight(), true);
      expect(
        value.fold((l) => l, (r) => r),
        AppRoute('/authentication/sign_in_stealth'),
      );
    });

    test(
        'inactivity returns active customer error when they are inactive for 29 seconds',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(const Duration(seconds: 29)),
        now: now,
        stealthModeEnabled: true,
        anonymousModeEnabled: true,
      );

      expect(value.isLeft(), true);
      expect(value.fold((l) => l, (r) => r), InactivityError.customerActive);
    });

    test('inactivity returns active customer error for null value of inactive',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: null,
        now: now,
        stealthModeEnabled: true,
        anonymousModeEnabled: true,
      );

      expect(value.isLeft(), true);
      expect(value.fold((l) => l, (r) => r), InactivityError.customerActive);
    });

    test(
        'inactivity returns no logout required error when they are inactive for 30 seconds but neither stealth or anonymous modes are enabled',
        () async {
      final value = await _inactivityRoute(
        inactiveSince: now.subtract(
          const Duration(seconds: 30),
        ),
        now: now,
        stealthModeEnabled: false,
        anonymousModeEnabled: false,
      );

      expect(value.isLeft(), true);
      expect(
        value.fold((l) => l, (r) => r),
        InactivityError.customerNotStealth,
      );
    });
  });
}

class MockUserProfileStore extends Mock
    implements LocalStore<UserProfileEntity> {}

class MockAppPreferencesStore extends Mock
    implements LocalStore<AppPreferencesEntity> {}
