import 'package:penhas/app/core/managers/local_store.dart';
import 'package:penhas/app/core/storage/i_local_storage.dart';
import 'package:penhas/app/features/appstate/data/model/app_preferences_model.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

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
  Map<String, dynamic> toJson(AppPreferencesEntity appPreferences) {
    final model = AppPreferencesModel(
      inactiveAppSince: appPreferences.inactiveAppSince,
      inactiveAppLogoutTimeInSeconds:
          appPreferences.inactiveAppLogoutTimeInSeconds,
    );
    return model.toJson();
  }
}
