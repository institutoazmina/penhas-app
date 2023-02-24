import '../../features/appstate/data/model/app_preferences_model.dart';
import '../../features/appstate/domain/entities/app_preferences_entity.dart';
import '../storage/i_local_storage.dart';
import 'local_store.dart';

class AppPreferencesStore extends LocalStore<AppPreferencesEntity> {
  AppPreferencesStore({required ILocalStorage storage})
      : super('br.com.penhas.app_preferences', storage);

  @override
  AppPreferencesEntity defaultEntity() => const AppPreferencesEntity(
        inactiveAppSince: null,
        inactiveAppLogoutTimeInSeconds: 30,
      );

  @override
  AppPreferencesEntity fromJson(Map<String, dynamic> json) {
    return AppPreferencesModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(AppPreferencesEntity entity) {
    final model = AppPreferencesModel(
      inactiveAppSince: entity.inactiveAppSince,
      inactiveAppLogoutTimeInSeconds: entity.inactiveAppLogoutTimeInSeconds,
    );
    return model.toJson();
  }
}
