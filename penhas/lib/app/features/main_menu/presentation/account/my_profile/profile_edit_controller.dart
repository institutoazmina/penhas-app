import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/states/profile_edit_state.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController extends _ProfileEditControllerBase
    with _$ProfileEditController {
  ProfileEditController({@required AppStateUseCase appStateUseCase})
      : super(appStateUseCase);
}

abstract class _ProfileEditControllerBase with Store, MapFailureMessage {
  final AppStateUseCase _appStateUseCase;

  _ProfileEditControllerBase(this._appStateUseCase) {
    loadProfile();
  }

  @observable
  ProfileEditState state = ProfileEditState.initial();

  @observable
  PageProgressState progressState = PageProgressState.initial;

  @action
  Future<void> retry() async {
    loadProfile();
  }

  @action
  Future<void> editNickName(String name) async {
    print("editNickName => $name");
  }

  @action
  Future<void> editMinibio(String content) async {
    print("editMinibio => $content");
  }
}

extension _PrivateMethod on _ProfileEditControllerBase {
  Future<void> loadProfile() async {
    final result = await _appStateUseCase.check();
    result.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleSession(session),
    );
  }

  void handleSession(AppStateEntity session) {
    state = ProfileEditState.loaded(session.userProfile);
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    state = ProfileEditState.error(message);
  }
}
