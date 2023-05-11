import 'package:dartz/dartz.dart';

import '../../../../core/managers/local_store.dart';
import '../../../../shared/navigation/app_route.dart';
import '../entities/app_preferences_entity.dart';
import '../entities/user_profile_entity.dart';

class InactivityLogoutUseCase {
  InactivityLogoutUseCase({
    required LocalStore<AppPreferencesEntity> appPreferencesStore,
    required LocalStore<UserProfileEntity> userProfileStore,
  })  : _appPreferencesStore = appPreferencesStore,
        _userProfileStore = userProfileStore;

  final LocalStore<AppPreferencesEntity> _appPreferencesStore;
  final LocalStore<UserProfileEntity> _userProfileStore;

  Future<Either<InactivityError, AppRoute>> inactivityRoute(DateTime now) {
    return _appPreferencesStore
        .retrieve()
        .then((preferences) => _inactiveForTooLong(now, preferences))
        .then(_routeForInactiveCustomer);
  }

  Future<Either<InactivityError, AppRoute>> _routeForInactiveCustomer(
    bool isInactive,
  ) async {
    if (!isInactive) return left(InactivityError.customerActive);

    final profile = await _userProfileStore.retrieve();

    if (profile.stealthModeEnabled) {
      return right(AppRoute('/authentication/stealth'));
    }
    if (profile.anonymousModeEnabled) {
      return right(AppRoute('/authentication/sign_in_stealth'));
    }

    return left(InactivityError.customerNotStealth);
  }

  bool _inactiveForTooLong(DateTime now, AppPreferencesEntity preferences) {
    if (preferences.inactiveAppSince == null) return false;

    final asOf = now.millisecondsSinceEpoch;
    final inactiveTimeInSeconds = (asOf - preferences.inactiveAppSince!) / 1000;
    return inactiveTimeInSeconds >= preferences.inactiveAppLogoutTimeInSeconds;
  }

  Future<void> setInactive(DateTime now) {
    return _appPreferencesStore
        .retrieve()
        .then((preferences) => _setAppInactive(now, preferences));
  }

  Future<void> _setAppInactive(DateTime now, AppPreferencesEntity preferences) {
    final entity = AppPreferencesEntity(
      inactiveAppSince: now.millisecondsSinceEpoch,
      inactiveAppLogoutTimeInSeconds:
          preferences.inactiveAppLogoutTimeInSeconds,
    );
    return _appPreferencesStore.save(entity);
  }

  Future<void> setActive() {
    return _appPreferencesStore.retrieve().then(_setAppActive);
  }

  Future<void> _setAppActive(AppPreferencesEntity preferences) {
    final entity = AppPreferencesEntity(
      inactiveAppSince: null,
      inactiveAppLogoutTimeInSeconds:
          preferences.inactiveAppLogoutTimeInSeconds,
    );
    return _appPreferencesStore.save(entity);
  }
}

enum InactivityError {
  customerActive,
  customerNotStealth,
}
