import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_tile_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_state.dart';

part 'guardians_controller.g.dart';

class GuardiansController extends _GuardiansControllerBase
    with _$GuardiansController {
  GuardiansController({@required IGuardianRepository guardianRepository})
      : super(guardianRepository);
}

abstract class _GuardiansControllerBase with Store, MapFailureMessage {
  final IGuardianRepository _guardianRepository;

  _GuardiansControllerBase(this._guardianRepository);

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
      (failure) => _handleLoadPageError(failure),
      (session) => _handleSession(session),
    );
  }

  void _handleSession(GuardianSessioEntity session) {
    final headers = session.guards
        .expand(
          (guardian) => _parseGuard(guardian),
        )
        .toList();

    currentState = GuardianState.loaded(headers);
  }

  List<GuardianTileEntity> _parseGuard(GuardianEntity guardian) {
    final header = GuardianTileHeaderEntity(title: guardian.meta.header);
    final description =
        GuardianTileDescriptionEntity(description: guardian.meta.description);
    final cards = guardian.contacts.map(
      (e) => GuardianTileCardEntity(
        name: e.name,
        mobile: e.mobile,
        status: e.status,
        onResendPressed:
            guardian.meta.canResend ? () async => _onResendPressed() : null,
        onEditPressed:
            guardian.meta.canEdit ? () async => _onEditPressed() : null,
        onDeletePressed:
            guardian.meta.canDelete ? () async => _onDeletePressed() : null,
      ),
    );

    return [header, description, ...cards, ...cards];
  }

  void _handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = GuardianState.error(message);
  }

  void _setErrorMessage(String message) => errorMessage = message;

  Future<void> _onEditPressed() async {
    print("_onEditPressed");
  }

  Future<void> _onDeletePressed() async {
    print("_onDeletePressed");
  }

  Future<void> _onResendPressed() async {
    print("_onResendPressed");
  }
}
