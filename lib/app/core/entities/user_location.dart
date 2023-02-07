import 'package:equatable/equatable.dart';

class UserLocationEntity extends Equatable {
  const UserLocationEntity({
    this.latitude = 0,
    this.longitude = 0,
    this.accuracy = 0,
  });

  final double latitude;
  final double longitude;
  final double accuracy;

  @override
  List<Object?> get props => [latitude, longitude, accuracy];
}
