import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/main_menu/domain/states/account_preference_state.dart';

part 'account_preference_controller.g.dart';

class AccountPreferenceController extends _AccountPreferenceControllerBase
    with _$AccountPreferenceController {}

abstract class _AccountPreferenceControllerBase with Store, MapFailureMessage {
  @observable
  AccountPreferenceState state = AccountPreferenceState.initial();
}
