import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

class AppPreferencesModel extends AppPreferencesEntity {
  const AppPreferencesModel({
    required int? inactiveAppSince,
    required int inactiveAppLogoutTimeInSeconds,
  }) : super(
          inactiveAppSince: inactiveAppSince,
          inactiveAppLogoutTimeInSeconds: inactiveAppLogoutTimeInSeconds,
        );

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
