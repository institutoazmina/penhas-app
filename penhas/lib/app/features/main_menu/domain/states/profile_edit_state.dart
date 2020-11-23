import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_edit_state.freezed.dart';

@freezed
abstract class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = _Initial;
  const factory ProfileEditState.error(String message) = _ErrorDetails;
}
