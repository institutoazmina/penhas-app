import 'package:equatable/equatable.dart';

class StealthModeTutorialState extends Equatable {
  const StealthModeTutorialState({
    required this.locationPermissionGranted,
  });

  const StealthModeTutorialState({
    required this.locationPermissionGranted});

  @override
  List<Object?> get props => [locationPermissionGranted];
}
