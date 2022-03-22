import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_center_state.freezed.dart';

@freezed
class SupportCenterState with _$SupportCenterState {
  const factory SupportCenterState.loaded() = _Loaded;
  const factory SupportCenterState.error(String message) = _ErrorDetails;
  const factory SupportCenterState.gpsError(String message) = _GpsError;
}
