import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/features/support_center/domain/entities/geolocation_entity.dart';

class GeoLocationModel extends GeolocationEntity {
  final String label;
  final String locationToken;
  final UserLocationEntity userLocation;

  GeoLocationModel({
    this.label,
    this.locationToken,
    this.userLocation,
  }) : super(
          label: label,
          locationToken: locationToken,
          userLocation: userLocation,
        );

  factory GeoLocationModel.fromJson(Map<String, Object> jsonData) {
    final label = jsonData["label"];
    final locationToken = jsonData["location_token"];

    return GeoLocationModel(
      label: label,
      locationToken: locationToken,
    );
  }
}
