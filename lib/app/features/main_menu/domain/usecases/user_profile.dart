import 'package:dartz/dartz.dart';

import '../../../../core/entities/valid_fiel.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/managers/local_store.dart';
import '../../../appstate/domain/entities/user_profile_entity.dart';
import '../../../appstate/domain/usecases/app_state_usecase.dart';
import '../repositories/user_profile_repository.dart';

class UserProfile {
  UserProfile({
    required AppStateUseCase appStateUseCase,
    required IUserProfileRepository repository,
    required LocalStore<UserProfileEntity> userProfileStore,
  })  : _repository = repository,
        _appStateUseCase = appStateUseCase,
        _userProfileStore = userProfileStore;

  final AppStateUseCase _appStateUseCase;
  final IUserProfileRepository _repository;
  final LocalStore<UserProfileEntity> _userProfileStore;

  Future<Either<Failure, ValidField>> anonymousMode({
    required bool toggle,
  }) async {
    final securityMode = await _repository.anonymousMode(toggle: toggle);

    return securityMode.fold(
      (failure) => left(failure),
      (success) => _syncAppState(),
    );
  }

  Future<Either<Failure, ValidField>> stealthMode({
    required bool toggle,
  }) async {
    final securityMode = await _repository.stealthMode(toggle: toggle);

    return securityMode.fold(
      (failure) => left(failure),
      (success) => _syncAppState(),
    );
  }

  Future<UserProfileEntity> currentProfile() async {
    return _userProfileStore.retrieve();
  }

  Future<void> logout() {
    return _userProfileStore.delete();
  }

  Future<Either<Failure, ValidField>> _syncAppState() async {
    await _appStateUseCase.check();
    return right(const ValidField());
  }
}
