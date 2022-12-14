import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:penhas/app/features/users/domain/entities/user_detail_entity.dart';

part 'user_profile_state.freezed.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;
  const factory UserProfileState.loaded(UserDetailEntity person) = _Loaded;
  const factory UserProfileState.error(String message) = _ErrorDetails;
}
