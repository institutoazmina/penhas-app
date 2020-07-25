import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_state.dart';

part 'new_guardian_controller.g.dart';

class NewGuardianController extends _NewGuardianControllerBase
    with _$NewGuardianController {
  NewGuardianController({@required IGuardianRepository guardianRepository})
      : super(guardianRepository);
}

abstract class _NewGuardianControllerBase with Store, MapFailureMessage {
  final IGuardianRepository _guardianRepository;

  _NewGuardianControllerBase(this._guardianRepository);

  @observable
  ObservableFuture<Either<Failure, GuardianSessioEntity>> _fetchProgress;

  @observable
  String errorMessage = '';

  @observable
  GuardianState currentState = GuardianState.initial();

  @computed
  PageProgressState get loadState {
    if (_fetchProgress == null ||
        _fetchProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _fetchProgress.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  @action
  Future<void> loadPage() async {
    _setErrorMessage('');
    _fetchProgress = ObservableFuture(_guardianRepository.fetch());

    final response = await _fetchProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) => _handleSession(session),
    );
  }

  void _setErrorMessage(String message) {
    errorMessage = message;
  }

  void _handleSession(GuardianSessioEntity session) {
    if (session.remainingInvites == 0) {
      currentState = GuardianState.rateLimit(session.maximumInvites);
      return;
    }
  }
}
