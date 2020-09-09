import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

class UserProfile {
  final IUserProfileRepository _repository;
  final IUserProfileStore _userProfileStore;

  UserProfile({
    @required IUserProfileRepository repository,
    @required IUserProfileStore userProfileStore,
  })  : this._repository = repository,
        this._userProfileStore = userProfileStore;

  Future<Either<Failure, ValidField>> enableStealthMode() async {
    return _repository.stealthMode(toggle: true);
  }

  Future<Either<Failure, ValidField>> disableStealthMode() async {
    return _repository.stealthMode(toggle: false);
  }

  Future<Either<Failure, ValidField>> enableAnonymousMode() async {
    return _repository.anonymousMode(toggle: true);
  }

  Future<Either<Failure, ValidField>> disableAnonymousMode() async {
    return _repository.anonymousMode(toggle: false);
  }

  Future<String> userName() async {
    return _userProfileStore
        .retreive()
        .then((v) => v.nickname)
        .catchError(_handleError);
  }

  Future<String> userAvatar() async {
    return _userProfileStore
        .retreive()
        .then((v) => v.avatar)
        .catchError(_handleError);
  }

  Future<void> logout() {
    return _userProfileStore.delete();
  }

  Future<String> _handleError(Object error) async {
    return "";
  }
}
