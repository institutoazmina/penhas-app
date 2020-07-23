import 'package:meta/meta.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

abstract class IUserProfileStore {
  Future<UserProfileEntity> retreive();
  Future<void> save(UserProfileEntity userProfile);
}

class UserProfileStore implements IUserProfileStore {
  final ILocalStorage _storage;
  final _profileKey = 'br.com.penhas.userProfile';

  UserProfileStore({@required ILocalStorage storage}) : this._storage = storage;

  @override
  Future<UserProfileEntity> retreive() {
    throw UnimplementedError();
  }

  @override
  Future<void> save(UserProfileEntity userProfile) {
    throw UnimplementedError();
  }
}
