import 'package:equatable/equatable.dart';
import 'package:penhas/app/core/entities/user_location.dart';

class GeolocationEntity extends Equatable {
  final String label;
  final String locationToken;
  final UserLocationEntity userLocation;

  GeolocationEntity({
    this.label,
    this.locationToken,
    this.userLocation,
  });

  @override
  List<Object> get props => [label, locationToken, userLocation];
}
