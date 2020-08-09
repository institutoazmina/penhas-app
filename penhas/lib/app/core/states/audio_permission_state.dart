import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'audio_permission_state.freezed.dart';

@freezed
abstract class AudioPermissionState with _$AudioPermissionState {
  const factory AudioPermissionState.granted() = _Granted;
  const factory AudioPermissionState.denied() = _Denied;
  const factory AudioPermissionState.permanentlyDenied() = _PermanentlyDenied;
  const factory AudioPermissionState.restricted() = _Restricted;
  const factory AudioPermissionState.undefined() = _Undefined;
}
