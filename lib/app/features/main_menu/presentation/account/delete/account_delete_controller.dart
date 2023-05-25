import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/entities/valid_fiel.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/managers/app_configuration.dart';
import '../../../../authentication/presentation/shared/map_failure_message.dart';
import '../../../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../../domain/repositories/user_profile_repository.dart';
import '../../../domain/states/profile_delete_state.dart';

part 'account_delete_controller.g.dart';

class AccountDeleteController extends _AccountDeleteControllerBase
    with _$AccountDeleteController {
  AccountDeleteController({
    required IAppConfiguration appConfiguration,
    required IUserProfileRepository profileRepository,
  }) : super(profileRepository, appConfiguration);
}

abstract class _AccountDeleteControllerBase with Store, MapFailureMessage {
  _AccountDeleteControllerBase(
    this._profileRepository,
    this._appConfiguration,
  ) {
    loadPage();
  }

  final IAppConfiguration _appConfiguration;
  final IUserProfileRepository _profileRepository;

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _progress;

  @observable
  ProfileDeleteState state = const ProfileDeleteState.initial();

  @observable
  String? errorMessage = '';

  @computed
  PageProgressState get progressState {
    return monitorProgress(_progress);
  }

  @action
  Future<void> delete(String password) async {
    errorMessage = '';
    _progress = ObservableFuture(
      _profileRepository.delete(password: password),
    );

    final Either<Failure, ValidField> result = await _progress!;

    result.fold(
      (failure) => handleDeleteError(failure),
      (session) => handleDeleteSession(session),
    );
  }

  @action
  Future<void> retry() async {
    loadPage();
  }
}

extension _PrivateMethods on _AccountDeleteControllerBase {
  Future<void> loadPage() async {
    final response = await _profileRepository.deleteNotice();

    response.fold(
      (failure) => handleLoadPageError(failure),
      (session) => handleSession(session),
    );
  }

  void handleLoadPageError(Failure failure) {
    final message = mapFailureMessage(failure);
    state = ProfileDeleteState.error(message);
  }

  void handleSession(ValidField session) {
    state = ProfileDeleteState.loaded(session.message!);
  }

  void handleDeleteError(Failure failure) {
    errorMessage = mapFailureMessage(failure);
  }

  void handleDeleteSession(ValidField session) {
    _appConfiguration.logout();
    Modular.to.pushNamedAndRemoveUntil(
      '/',
      ModalRoute.withName('/'),
    );
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
