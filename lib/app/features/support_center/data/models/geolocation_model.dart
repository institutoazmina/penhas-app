import '../../../../core/entities/user_location.dart';
import '../../domain/entities/geolocation_entity.dart';

class GeoLocationModel extends GeolocationEntity {
  const GeoLocationModel({
    String? label,
    String? locationToken,
    UserLocationEntity? userLocation,
  }) : super(
          label: label,
          locationToken: locationToken,
          userLocation: userLocation,
        );

  factory GeoLocationModel.fromJson(Map<String, dynamic> jsonData) =>
      GeoLocationModel(
        label: jsonData['label'],
        locationToken: jsonData['location_token'],
      );
}
