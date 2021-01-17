import 'package:meta/meta.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_preferences_entity.dart';

class AppPreferencesModel extends AppPreferencesEntity {
  final int inactiveAppSince;
  final int inactiveAppLogoutTime;

  AppPreferencesModel({
    @required this.inactiveAppSince,
    @required this.inactiveAppLogoutTime,
  }) : super(
          inactiveAppSince: inactiveAppSince,
          inactiveAppLogoutTime: inactiveAppLogoutTime,
        );

  AppPreferencesModel.fromJson(Map<String, Object> jsonData)
      : inactiveAppSince = jsonData['inactiveAppSince'],
        inactiveAppLogoutTime = jsonData['inactiveAppLogoutTime'];

  Map<String, Object> toJson() => {
        'inactive_app_since': inactiveAppSince,
        'inactive_app_logout_time': inactiveAppLogoutTime
      };
}
