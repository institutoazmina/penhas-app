import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_permission_state.freezed.dart';

@freezed
class LocationPermissionState with _$LocationPermissionState {
  const factory LocationPermissionState.granted() = _Granted;
  const factory LocationPermissionState.denied() = _Denied;
  const factory LocationPermissionState.permanentlyDenied() =
      _PermanentlyDenied;
  const factory LocationPermissionState.restricted() = _Restricted;
  const factory LocationPermissionState.undefined() = _Undefined;
}
