import 'package:equatable/equatable.dart';

class UserLocationEntity extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracy;
  const UserLocationEntity({this.latitude, this.longitude, this.accuracy});

  @override
  List<Object> get props => [latitude, longitude, accuracy];

  @override
  String toString() {
    return 'UserLocation(latitude: ${latitude.toString()}, longitude: ${longitude.toString()}, accuracy: ${accuracy.toString()})';
  }
}
