import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_edit_state.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController extends _ProfileEditControllerBase
    with _$ProfileEditController {
  ProfileEditController({@required AppStateUseCase appStateUseCase})
      : super(appStateUseCase);
}

abstract class _ProfileEditControllerBase with Store {
  final AppStateUseCase _appStateUseCase;

  _ProfileEditControllerBase(this._appStateUseCase);

  @observable
  ProfileEditState state = ProfileEditState.error("Ocorreu um erro");

  @action
  Future<void> retry() {
    print("retry");
  }
}
