import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'new_guardian_state.freezed.dart';

@freezed
abstract class NewGuardianState with _$NewGuardianState {
  const factory NewGuardianState.initial() = _Initial;
  const factory NewGuardianState.loaded() = _Loaded;
  const factory NewGuardianState.error([String message]) = _ErrorDetails;
  const factory NewGuardianState.rateLimit(int maxLimit) = _RateLimit;
}
