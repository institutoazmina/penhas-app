import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
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
  ObservableFuture<Either<Failure, dynamic>> _updateProgress;

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

  @computed
  PageProgressState get updateState {
    if (_updateProgress == null ||
        _updateProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _updateProgress.status == FutureStatus.pending
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
    final headers =
        session.guards.expand((guardian) => _parseGuard(guardian)).toList();

    currentState = GuardianState.loaded(headers);
  }

  List<GuardianTileEntity> _parseGuard(GuardianEntity guardian) {
    final header = GuardianTileHeaderEntity(title: guardian.meta.header);
    final description =
        GuardianTileDescriptionEntity(description: guardian.meta.description);
    List<GuardianTileEntity> cards = guardian.contacts
        .map(
          (e) => GuardianTileCardEntity(
            guardian: e,
            deleteWarning: guardian.meta.deleteWarning,
            onEditPressed: guardian.meta.canEdit
                ? (name) async => _onEditPressed(e, name)
                : null,
            onResendPressed: guardian.meta.canResend
                ? () async => _onResendPressed(e)
                : null,
            onDeletePressed: guardian.meta.canDelete
                ? () async => _onDeletePressed(e)
                : null,
          ),
        )
        .toList();

    if (cards.isEmpty) {
      cards = [
        GuardianTileEmptyCardEntity(onPressed: () async => _onRegisterGuadian())
      ];
    }

    return [header, description, ...cards];
  }

  void _handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = GuardianState.error(message);
  }

  void _setErrorMessage(String message) => errorMessage = message;

  Future<void> _onEditPressed(
    GuardianContactEntity contact,
    String name,
  ) async {
    _setErrorMessage('');
    if (contact == null || name == null) {
      return;
    }

    final newContact = contact.copyWith(name: name);

    _updateProgress = ObservableFuture(_guardianRepository.update(newContact));
    final response = await _updateProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) async => loadPage(),
    );
  }

  Future<void> _onDeletePressed(GuardianContactEntity contact) async {
    _setErrorMessage('');
    if (contact == null) return;

    _updateProgress = ObservableFuture(_guardianRepository.delete(contact));
    final response = await _updateProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) async => loadPage(),
    );
  }

  Future<void> _onResendPressed(GuardianContactEntity contact) async {
    _setErrorMessage('');
    if (contact == null) return;

    _updateProgress = ObservableFuture(_guardianRepository.create(contact));
    final response = await _updateProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) async => loadPage(),
    );
  }

  Future<void> _onRegisterGuadian() async {
    Modular.to.pushNamed('/mainboard/helpcenter/newGuardian').then(
      (value) {
        // Se o new_guardian inserir um usuário, aparecerá um popup
        // com uma mensagem. Ao selecionar o 'Fechar' retornará
        // um boolean == true, que vou utilizar aqui para fazer
        // reload da pagina
        if (value != null && value is bool && value == true) {
          loadPage();
        }
      },
    );
  }
}
