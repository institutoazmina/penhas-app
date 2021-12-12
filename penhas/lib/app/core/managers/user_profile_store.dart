import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/user_profile_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

class UserProfileStore extends LocalStore<UserProfileEntity> {
  UserProfileStore({required ILocalStorage storage})
      : super('br.com.penhas.userProfile', storage);

  @override
<<<<<<< HEAD
  UserProfileEntity defaultEntity() => UserProfileEntity(
        email: null,
        nickname: null,
        avatar: null,
        stealthModeEnabled: false,
        anonymousModeEnabled: false,
        birthdate: DateTime.now(),
        fullName: null,
        genre: null,
        jaFoiVitimaDeViolencia: false,
        minibio: null,
        race: null,
        skill: const [],
      );
=======
  Future<UserProfileEntity> defaultEntity() {
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
        skill: null,
      ),
    );
  }
>>>>>>> Fix code syntax

  @override
  UserProfileEntity fromJson(Map<String, dynamic> json) {
    return UserProfileModel.fromJson(json);
  }

  @override
  Map<String, Object?> toJson(UserProfileEntity userProfile) {
    final model = UserProfileModel(
      fullName: userProfile.fullName,
      genre: userProfile.genre,
      jaFoiVitimaDeViolencia: userProfile.jaFoiVitimaDeViolencia ?? false,
      minibio: userProfile.genre,
      race: userProfile.race,
      skill: userProfile.skill,
      email: userProfile.email,
      nickname: userProfile.nickname,
      avatar: userProfile.avatar,
      stealthModeEnabled: userProfile.stealthModeEnabled ?? false,
      anonymousModeEnabled: userProfile.anonymousModeEnabled ?? false,
      birthdate: userProfile.birthdate,
    );
    return model.toJson();
  }
}
