import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

class AppStateUseCase {
  final IAppStateRepository _appStateRepository;
  final IUserProfileStore _userProfileStore;
  final IAppConfiguration _appConfiguration;

  AppStateUseCase({
    @required IAppStateRepository appStateRepository,
    @required IUserProfileStore userProfileStore,
    @required IAppConfiguration appConfiguration,
  })  : this._appStateRepository = appStateRepository,
        this._appConfiguration = appConfiguration,
        this._userProfileStore = userProfileStore;

  Future<Either<Failure, AppStateEntity>> check() async {
    final currentState = await _appStateRepository.check();
    return currentState.fold(
      (failure) => left(failure),
      (appState) => _processAppState(appState),
    );
  }

  Future<Either<Failure, AppStateEntity>> _processAppState(
      AppStateEntity appStateEntity) async {
    await _userProfileStore.save(appStateEntity.userProfile);
    await _appConfiguration.saveAppModes(appStateEntity.appMode);
    return right(appStateEntity);
  }
}
