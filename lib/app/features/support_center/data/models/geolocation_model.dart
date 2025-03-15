import '../../domain/entities/geolocation_entity.dart';

class GeoLocationModel extends GeolocationEntity {
  const GeoLocationModel({
    super.label,
    super.locationToken,
    super.userLocation,
  });

  factory GeoLocationModel.fromJson(Map<String, dynamic> jsonData) =>
      GeoLocationModel(
        label: jsonData['label'],
        locationToken: jsonData['location_token'],
      );
}
