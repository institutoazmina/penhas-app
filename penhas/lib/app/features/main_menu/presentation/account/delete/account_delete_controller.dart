import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_delete_state.dart';

part 'account_delete_controller.g.dart';

class AccountDeleteController extends _AccountDeleteControllerBase
    with _$AccountDeleteController {}

abstract class _AccountDeleteControllerBase with Store, MapFailureMessage {
  _AccountDeleteControllerBase() {
    loadPage();
  }

  @observable
  ProfileDeleteState state = ProfileDeleteState.initial();

  @action
  Future<void> retry() async {
    loadPage();
  }
}

extension _PrivateMethods on _AccountDeleteControllerBase {
  Future<void> loadPage() async {}
}
