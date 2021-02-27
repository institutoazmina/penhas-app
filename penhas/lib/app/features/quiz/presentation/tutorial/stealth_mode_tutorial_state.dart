import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class StealthModeTutorialState extends Equatable {
  final bool locationPermissionGranted;

  StealthModeTutorialState({
    @required this.locationPermissionGranted});

  @override
  List<Object> get props => [locationPermissionGranted];
}