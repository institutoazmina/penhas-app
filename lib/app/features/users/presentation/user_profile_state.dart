import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/user_detail_entity.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;
  const factory UserProfileState.loaded(UserDetailEntity person) = _Loaded;
  const factory UserProfileState.error(String message) = _ErrorDetails;
}

@freezed
class UserMenuState with _$UserMenuState {
  const factory UserMenuState.hidden() = _MenuStateHidden;
  const factory UserMenuState.visible() = _MenuStateVisible;
}

@freezed
class UserProfileReaction with _$UserProfileReaction {
  factory UserProfileReaction.showSnackBar(String message) =
      _ReactionShowSnackBar;
  factory UserProfileReaction.showProfileOptions() =
      _ReactionShowProfileOptions;
  factory UserProfileReaction.askReportReasonDialog([
    @Default(null) String? reason,
  ]) = _ReactionAskReportReasonDialog;
  factory UserProfileReaction.showProgressDialog() =
      _ReactionShowProgressDialog;
  factory UserProfileReaction.dismissProgressDialog() =
      _ReactionDismissProgressDialog;
}

@freezed
class UserProfileSelectedOption with _$UserProfileSelectedOption {
  factory UserProfileSelectedOption.report() = _SelectedOptionReport;
}
