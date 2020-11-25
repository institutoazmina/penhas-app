import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

abstract class IUserProfileStore {
  Future<UserProfileEntity> retreive();
  Future<void> save(UserProfileEntity userProfile);
  Future<void> delete();
}

class UserProfileStore implements IUserProfileStore {
  final ILocalStorage _storage;
  final _profileKey = 'br.com.penhas.userProfile';

  UserProfileStore({@required ILocalStorage storage}) : this._storage = storage;

  @override
  Future<UserProfileEntity> retreive() async {
    return _storage
        .get(_profileKey)
        .then((data) => json.decode(data) as Map<String, Object>)
        .then((json) => UserProfileModel.fromJson(json))
        .catchError(_parseRetrieveError);
  }

  Future<UserProfileEntity> _parseRetrieveError(Object error) {
    return Future.value(
      UserProfileEntity(
          email: null,
          nickname: null,
          avatar: null,
          stealthModeEnabled: null,
          anonymousModeEnabled: null,
          birthdate: DateTime.now(),
          fullName: null,
          genre: null,
          jaFoiVitimaDeViolencia: null,
          minibio: null,
          race: null,
          skill: null),
    );
  }

  @override
  Future<void> save(UserProfileEntity userProfile) {
    final profileJson = UserProfileModel(
      fullName: userProfile.fullName,
      genre: userProfile.genre,
      jaFoiVitimaDeViolencia: userProfile.jaFoiVitimaDeViolencia,
      minibio: userProfile.genre,
      race: userProfile.race,
      skill: userProfile.skill,
      email: userProfile.email,
      nickname: userProfile.nickname,
      avatar: userProfile.avatar,
      stealthModeEnabled: userProfile.stealthModeEnabled,
      anonymousModeEnabled: userProfile.anonymousModeEnabled,
      birthdate: userProfile.birthdate,
    )..toJson();

    final jsonString = json.encode(profileJson);
    return _storage.put(_profileKey, jsonString);
  }

  @override
  Future<void> delete() {
    return _storage.delete(_profileKey);
  }
}
