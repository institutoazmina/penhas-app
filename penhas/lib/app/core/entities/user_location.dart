import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  final double latitude;
  final double longitude;
  const UserLocation({this.latitude, this.longitude})
      : assert(latitude != null),
        assert(longitude != null);

  @override
  List<Object> get props => [latitude, longitude];

  @override
  String toString() {
    return 'UserLocation(latitude: ${latitude.toString()}, longitude: ${longitude.toString()})';
  }
}
