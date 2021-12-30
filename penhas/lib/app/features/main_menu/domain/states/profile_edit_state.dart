import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:penhas/app/features/appstate/domain/entities/user_profile_entity.dart';

part 'profile_edit_state.freezed.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState.initial() = _Initial;
  const factory ProfileEditState.loaded(
    UserProfileEntity profile, {
    required bool securityModeFeatureEnabled,
  }) = _Loaded;
  const factory ProfileEditState.error(String message) = _ErrorDetails;
}
