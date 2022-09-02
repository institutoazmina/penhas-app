import 'package:equatable/equatable.dart';

class StealthModeTutorialState extends Equatable {
  const StealthModeTutorialState({
    required this.locationPermissionGranted,
  });

  final bool locationPermissionGranted;

  @override
  List<Object?> get props => [locationPermissionGranted];
}
