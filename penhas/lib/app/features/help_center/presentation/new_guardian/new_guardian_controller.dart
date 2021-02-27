import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/location_services.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/help_center/data/repositories/guardian_repository.dart';
import 'package:penhas/app/features/help_center/domain/entities/guardian_session_entity.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/new_guardian_state.dart';
import 'package:penhas/app/features/help_center/presentation/widget/RequestLocationPermissionContentWidget.dart';

part 'new_guardian_controller.g.dart';

class NewGuardianController extends _NewGuardianControllerBase
    with _$NewGuardianController {
  NewGuardianController({
    @required IGuardianRepository guardianRepository,
    @required ILocationServices locationService,
  }) : super(guardianRepository, locationService);
}

abstract class _NewGuardianControllerBase with Store, MapFailureMessage {
  final IGuardianRepository _guardianRepository;
  final ILocationServices _locationService;
  String guardianName;
  String guardianMobile;

  _NewGuardianControllerBase(
    this._guardianRepository,
    this._locationService,
  );

  @observable
  ObservableFuture<Either<Failure, GuardianSessioEntity>> _fetchProgress;

  @observable
  ObservableFuture<Either<Failure, ValidField>> _createProgress;

  @observable
  String errorMessage = '';

  @observable
  String warningMobile = '';

  @observable
  String warningName = '';

  @observable
  NewGuardianState currentState = NewGuardianState.initial();

  @observable
  GuardianAlertState alertState = GuardianAlertState.initial();

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
  PageProgressState get createState {
    if (_createProgress == null ||
        _createProgress.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return _createProgress.status == FutureStatus.pending
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

  @action
  void setGuardianName(String name) {
    guardianName = name;

    if (guardianName != null || guardianName.isNotEmpty) {
      warningName = '';
    }
  }

  @action
  void setGuardianMobile(String mobile) {
    guardianMobile = mobile;

    if (guardianMobile != null || guardianMobile.isNotEmpty) {
      warningMobile = '';
    }
  }

  @action
  Future<void> addGuardian() async {
    warningName = '';
    warningMobile = '';

    if (guardianName == null || guardianName.isEmpty) {
      warningName = 'É necessário informar o nome';
    }

    if (guardianMobile == null || guardianMobile.isEmpty) {
      warningMobile = 'É necessário informar o celular';
    }

    if (warningMobile.isNotEmpty || warningName.isNotEmpty) {
      return;
    }

    _setErrorMessage('');
    final guardian = GuardianContactEntity.createRequest(
      name: guardianName,
      mobile: guardianMobile,
    );

    _createProgress = ObservableFuture(_guardianRepository.create(guardian));

    final response = await _createProgress;

    response.fold(
      (failure) => _setErrorMessage(mapFailureMessage(failure)),
      (session) => _handleCreatedGuardian(session),
    );
  }

  void _handleSession(GuardianSessioEntity session) {
    if (session.remainingInvites == 0) {
      currentState = NewGuardianState.rateLimit(session.maximumInvites);
      return;
    }

    currentState = NewGuardianState.loaded();
  }

  void _handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    currentState = NewGuardianState.error(message);
  }

  void _setErrorMessage(String message) => errorMessage = message;

  void _handleCreatedGuardian(ValidField field) {
    alertState = GuardianAlertState.alert(
      GuardianAlertMessageAction(
        message: field.message,
        onPressed: () async => _actionAfterNotice(),
      ),
    );
  }

  void _actionAfterNotice() async {
    await _locationService
        .requestPermission(
            title: 'O guardião precisa da sua localização',
            description: buildRequestPermissionContent())
        .then((value) => Modular.to.pop(true));
  }
}

extension _WidgetBuilderPrivate on _NewGuardianControllerBase {
  Widget buildRequestPermissionContent() {
    return RequestLocationPermissionContentWidget();
  }
}
