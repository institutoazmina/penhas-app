import '../../domain/entities/app_preferences_entity.dart';

class AppPreferencesModel extends AppPreferencesEntity {
  const AppPreferencesModel({
    required super.inactiveAppSince,
    required super.inactiveAppLogoutTimeInSeconds,
  });

  factory AppPreferencesModel.fromJson(Map<String, dynamic> jsonData) =>
      AppPreferencesModel(
        inactiveAppSince: jsonData['inactive_app_since'],
        inactiveAppLogoutTimeInSeconds:
            jsonData['inactive_app_logout_time'] ?? 30,
      );

  Map<String, dynamic> toJson() => {
        'inactive_app_since': inactiveAppSince,
        'inactive_app_logout_time': inactiveAppLogoutTimeInSeconds
      };
}
