import 'package:dartz/dartz.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/managers/modules_sevices.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

class AppStateUseCase {
  final IAppStateRepository? _appStateRepository;
  final LocalStore<UserProfileEntity?>? _userProfileStore;
  final IAppConfiguration? _appConfiguration;
  final IAppModulesServices? _appModulesServices;

  AppStateUseCase({
    required IAppStateRepository? appStateRepository,
    required LocalStore<UserProfileEntity?>? userProfileStore,
    required IAppConfiguration? appConfiguration,
    required IAppModulesServices? appModulesServices,
  })  : this._appStateRepository = appStateRepository,
        this._appConfiguration = appConfiguration,
        this._userProfileStore = userProfileStore,
        this._appModulesServices = appModulesServices;

  Future<Either<Failure, AppStateEntity>> check() async {
    final currentState = await _appStateRepository!.check();
    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> update(
      UpdateUserProfileEntity update) async {
    final currentState = await _appStateRepository!.update(update);

    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> _processAppState(
      AppStateEntity appStateEntity) async {
    await _userProfileStore!.save(appStateEntity.userProfile);
    await _appConfiguration!.saveAppModes(appStateEntity.appMode);
    await _appModulesServices!.save(appStateEntity.modules);
    return right(appStateEntity);
  }
}
