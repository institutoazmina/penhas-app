import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/managers/app_configuration.dart';
import '../../../../core/managers/local_store.dart';
import '../../../../core/managers/modules_sevices.dart';
import '../entities/app_state_entity.dart';
import '../entities/update_user_profile_entity.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/i_app_state_repository.dart';

class AppStateUseCase {
  AppStateUseCase({
    required IAppStateRepository appStateRepository,
    required LocalStore<UserProfileEntity> userProfileStore,
    required IAppConfiguration appConfiguration,
    required IAppModulesServices appModulesServices,
  })  : _appStateRepository = appStateRepository,
        _appConfiguration = appConfiguration,
        _userProfileStore = userProfileStore,
        _appModulesServices = appModulesServices;

  final IAppStateRepository _appStateRepository;
  final LocalStore<UserProfileEntity> _userProfileStore;
  final IAppConfiguration _appConfiguration;
  final IAppModulesServices _appModulesServices;

  Future<Either<Failure, AppStateEntity>> check() async {
    final currentState = await _appStateRepository.check();
    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> update(
    UpdateUserProfileEntity update,
  ) async {
    final currentState = await _appStateRepository.update(update);

    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> _processAppState(
    AppStateEntity appStateEntity,
  ) async {
    final userProfile = appStateEntity.userProfile;
    if (userProfile != null) {
      await _userProfileStore.save(userProfile);
    }
    await _appConfiguration.saveAppModes(appStateEntity.appMode);
    await _appModulesServices.save(appStateEntity.modules);
    return right(appStateEntity);
  }
}
