import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:penhas/app/features/main_menu/domain/entities/account_preference_entity.dart';

part 'account_preference_state.freezed.dart';

@freezed
abstract class AccountPreferenceState with _$AccountPreferenceState {
  const factory AccountPreferenceState.initial() = _Initial;
  const factory AccountPreferenceState.loaded(
      List<AccountPreferenceEntity> preferences) = _Loaded;
  const factory AccountPreferenceState.error(String message) = _ErrorDetails;
}
