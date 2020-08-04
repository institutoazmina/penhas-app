import 'package:equatable/equatable.dart';

class UserLocationEntity extends Equatable {
  final double latitude;
  final double longitude;
  const UserLocationEntity({this.latitude, this.longitude});

  @override
  List<Object> get props => [latitude, longitude];

  @override
  String toString() {
    return 'UserLocation(latitude: ${latitude.toString()}, longitude: ${longitude.toString()})';
  }
}
