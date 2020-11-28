import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_preference_state.freezed.dart';

@freezed
abstract class AccountPreferenceState with _$AccountPreferenceState {
  const factory AccountPreferenceState.initial() = _Initial;
  // const factory AccountPreferenceState.loaded(String message) = _Loaded;
  // const factory AccountPreferenceState.error(String message) = _ErrorDetails;
}
