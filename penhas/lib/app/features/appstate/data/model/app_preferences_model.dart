import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

class AppPreferencesModel extends AppPreferencesEntity {
  final int inactiveAppSince;
  final int inactiveAppLogoutTimeInSeconds;

  AppPreferencesModel({
    @required this.inactiveAppSince,
    @required this.inactiveAppLogoutTimeInSeconds,
  }) : super(
          inactiveAppSince: inactiveAppSince,
          inactiveAppLogoutTimeInSeconds: inactiveAppLogoutTimeInSeconds,
        );

  AppPreferencesModel.fromJson(Map<String, Object> jsonData)
      : inactiveAppSince = jsonData['inactive_app_since'],
        inactiveAppLogoutTimeInSeconds = jsonData['inactive_app_logout_time'] ?? 30;

  Map<String, Object> toJson() => {
        'inactive_app_since': inactiveAppSince,
        'inactive_app_logout_time': inactiveAppLogoutTimeInSeconds
      };
}
