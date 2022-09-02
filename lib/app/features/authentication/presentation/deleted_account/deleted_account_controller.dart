import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/entities/valid_fiel.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/authentication/presentation/shared/map_failure_message.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/main_menu/domain/repositories/user_profile_repository.dart';

part 'deleted_account_controller.g.dart';

class DeletedAccountController extends _DeletedAccountControllerBase
    with _$DeletedAccountController {
  DeletedAccountController({
    required IUserProfileRepository profileRepository,
    required IAppConfiguration appConfiguration,
    required String? sessionToken,
  }) : super(profileRepository, appConfiguration, sessionToken);
}

abstract class _DeletedAccountControllerBase with Store, MapFailureMessage {
  _DeletedAccountControllerBase(
    this._profileRepository,
    this._appConfiguration,
    this._sessionToken,
  );

  final String? _sessionToken;
  final IAppConfiguration _appConfiguration;
  final IUserProfileRepository _profileRepository;

  @observable
  ObservableFuture<Either<Failure, ValidField>>? _progress;

  @observable
  String? errorMessage = '';

  @computed
  PageProgressState get progressState {
    return monitorProgress(_progress);
  }

  @action
  Future<void> reactive() async {
    errorMessage = '';

    _progress = ObservableFuture(
      _profileRepository.reactivate(token: _sessionToken),
    );

    final Either<Failure, ValidField> result = await _progress!;

    result.fold(
      (failure) => handleError(failure),
      (session) => handleSession(session),
    );
  }
}

extension _PrivateMethods on _DeletedAccountControllerBase {
  PageProgressState monitorProgress(ObservableFuture<Object>? observable) {
    if (observable == null || observable.status == FutureStatus.rejected) {
      return PageProgressState.initial;
    }

    return observable.status == FutureStatus.pending
        ? PageProgressState.loading
        : PageProgressState.loaded;
  }

  void handleError(Failure failure) {
    errorMessage = mapFailureMessage(failure);
  }

  Future<void> handleSession(ValidField session) async {
    await _appConfiguration.saveApiToken(token: _sessionToken);
    Modular.to.pushReplacementNamed('/');
  }
}
