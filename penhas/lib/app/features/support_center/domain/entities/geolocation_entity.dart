import 'package:equatable/equatable.dart';
import 'package:penhas/app/core/entities/user_location.dart';

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
  bool get stringify => true;

  @override
  List<Object?> get props => [label, locationToken, userLocation];
}
