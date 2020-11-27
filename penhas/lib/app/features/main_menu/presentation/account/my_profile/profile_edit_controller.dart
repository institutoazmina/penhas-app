import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/entities/update_user_profile_entity.dart';
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
  ObservableFuture<Either<Failure, AppStateEntity>> _progress;

  @observable
  ProfileEditState state = ProfileEditState.initial();

  @computed
  PageProgressState get progressState {
    return monitorProgress(_progress);
  }

  @action
  Future<void> retry() async {
    loadProfile();
  }

  @action
  Future<void> editNickName(String name) async {
    final update = UpdateUserProfileEntity(nickName: name);
    updateProfile(update);
  }

  @action
  Future<void> editMinibio(String content) async {
    final update = UpdateUserProfileEntity(minibio: content);
    updateProfile(update);
  }

  @action
  Future<void> editSkill() async {
    print("editSkill");
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

  Future<void> updateProfile(UpdateUserProfileEntity update) async {
    _progress = ObservableFuture(
      _appStateUseCase.update(update),
    );

    final result = await _progress;

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

  PageProgressState monitorProgress(ObservableFuture<Object> observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }
}
