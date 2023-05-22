import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/entities/user_location.dart';

class GeolocationEntity extends Equatable {
  const GeolocationEntity({
    this.label,
    this.locationToken,
    this.userLocation,
  });

  final String? label;
  final String? locationToken;
  final UserLocationEntity? userLocation;

  @override
  List<Object?> get props => [label, locationToken, userLocation];

  LatLng toLatLng() => LatLng(userLocation!.latitude, userLocation!.longitude);
}
