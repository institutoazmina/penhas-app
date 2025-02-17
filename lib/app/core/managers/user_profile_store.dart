import '../../features/appstate/data/model/user_profile_model.dart';
import '../../features/appstate/domain/entities/user_profile_entity.dart';
import '../storage/i_local_storage.dart';
import 'local_store.dart';

typedef TimeProvider = DateTime Function();

class UserProfileStore extends LocalStore<UserProfileEntity> {
  UserProfileStore({
    required ILocalStorage storage,
    this.timeProvider = DateTime.now,
  }) : super('br.com.penhas.userProfile', storage);

  final TimeProvider timeProvider;

  @override
  UserProfileEntity defaultEntity() => UserProfileEntity(
        email: null,
        nickname: null,
        avatar: null,
        stealthModeEnabled: false,
        anonymousModeEnabled: false,
        birthdate: timeProvider(),
        fullName: null,
        genre: null,
        jaFoiVitimaDeViolencia: false,
        minibio: null,
        race: null,
        skill: const [],
        badges: const [],
      );

  @override
  UserProfileEntity fromJson(Map<String, dynamic> json) {
    return UserProfileModel.fromJson(json);
  }

  @override
  Map<String, Object?> toJson(UserProfileEntity entity) {
    final model = UserProfileModel(
      fullName: entity.fullName,
      genre: entity.genre,
      jaFoiVitimaDeViolencia: entity.jaFoiVitimaDeViolencia,
      minibio: entity.minibio,
      race: entity.race,
      skill: entity.skill,
      email: entity.email,
      nickname: entity.nickname,
      avatar: entity.avatar,
      stealthModeEnabled: entity.stealthModeEnabled,
      anonymousModeEnabled: entity.anonymousModeEnabled,
      birthdate: entity.birthdate,
    );
    return model.toJson();
  }
}
