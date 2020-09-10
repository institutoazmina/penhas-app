import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class UserProfile {
  final AppStateUseCase _appStateUseCase;
  final IUserProfileRepository _repository;
  final IUserProfileStore _userProfileStore;

  UserProfile({
    @required AppStateUseCase appStateUseCase,
    @required IUserProfileRepository repository,
    @required IUserProfileStore userProfileStore,
  })  : this._repository = repository,
        this._appStateUseCase = appStateUseCase,
        this._userProfileStore = userProfileStore;

  Future<Either<Failure, ValidField>> anonymousMode(bool toggle) async {
    final securityMode = await _repository.anonymousMode(toggle: toggle);

    return securityMode.fold(
      (failure) => left(failure),
      (success) => _syncAppState(),
    );
  }

  Future<Either<Failure, ValidField>> stealthMode(bool toggle) async {
    final securityMode = await _repository.stealthMode(toggle: toggle);

    return securityMode.fold(
      (failure) => left(failure),
      (success) => _syncAppState(),
    );
  }

  Future<UserProfileEntity> currentProfile() async {
    return _userProfileStore.retreive();
  }

  Future<void> logout() {
    return _userProfileStore.delete();
  }

  Future<Either<Failure, ValidField>> _syncAppState() async {
    await _appStateUseCase.check();
    return right(ValidField());
  }
}
