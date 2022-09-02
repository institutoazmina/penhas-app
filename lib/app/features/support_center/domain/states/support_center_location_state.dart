import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_center_location_state.freezed.dart';

@freezed
class SupportCenterLocationState with _$SupportCenterLocationState {
  const factory SupportCenterLocationState.initial() = _Initial;
  const factory SupportCenterLocationState.loaded(String message) = _Loaded;
  const factory SupportCenterLocationState.error(String message) =
      _ErrorDetails;
  const factory SupportCenterLocationState.addressNotFound(String message) =
      _AddressNotFound;
}
