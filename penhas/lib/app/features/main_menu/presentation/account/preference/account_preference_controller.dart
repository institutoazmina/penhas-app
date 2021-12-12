import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/entities/account_preference_entity.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';
import 'package:penhas/app/features/main_menu/domain/states/account_preference_state.dart';

part 'account_preference_controller.g.dart';

class AccountPreferenceController extends _AccountPreferenceControllerBase
    with _$AccountPreferenceController {
  AccountPreferenceController(
      {required IUserProfileRepository profileRepository})
      : super(profileRepository);
}

abstract class _AccountPreferenceControllerBase with Store, MapFailureMessage {
  _AccountPreferenceControllerBase(this._userProfileRepository) {
    loadPage();
  }

  final IUserProfileRepository _userProfileRepository;

  @observable
  ObservableFuture<Either<Failure, AccountPreferenceSessionEntity>>? _progress;

  @observable
  AccountPreferenceState state = const AccountPreferenceState.initial();

  @observable
  String? messageError = "";

  @computed
  PageProgressState get progress {
    return monitorProgress(_progress);
  }

  @action
  Future<void> retry() async {
    loadPage();
  }

  @action
  Future<void> update(String? key, bool status) async {
    setMessageErro("");
    _progress = ObservableFuture(
      _userProfileRepository.updatePreferences(key: key, status: status),
    );

    final Either<Failure, AccountPreferenceSessionEntity> result = await _progress!;

    result.fold(
      (failure) => handleUpdateError(failure),
      (session) => handleSession(session),
    );
  }
}

extension _MethodPrivate on _AccountPreferenceControllerBase {
  Future<void> loadPage() async {
    final result = await _userProfileRepository.preferences();

    result.fold(
      (failure) => handleError(failure),
      (session) => handleSession(session),
    );
  }

  void handleSession(AccountPreferenceSessionEntity session) {
    state = AccountPreferenceState.loaded(session.preferences);
  }

  void handleError(Failure failure) {
    final message = mapFailureMessage(failure)!;
    state = AccountPreferenceState.error(message);
  }

  void handleUpdateError(Failure failure) {
    final message = mapFailureMessage(failure);
    setMessageErro(message);
  }

  void setMessageErro(String? message) {
    messageError = message;
  }

  PageProgressState monitorProgress(ObservableFuture<Object>? observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }
}
