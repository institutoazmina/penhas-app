import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/core/managers/user_profile_store.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';
import 'package:penhas/app/shared/navigation/navigator.dart';
import 'package:penhas/app/shared/navigation/route.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    @required IAppConfiguration appConfiguration,
    @required AppStateUseCase appStateUseCase,
    @required IUserProfileStore userProfileStore,
  }) : super(appConfiguration, appStateUseCase, userProfileStore);
}

abstract class _SplashControllerBase with Store {
  final AppStateUseCase _appStateUseCase;
  final IAppConfiguration _appConfiguration;
  final IUserProfileStore _userProfileStore;

  _SplashControllerBase(
    this._appConfiguration,
    this._appStateUseCase,
    this._userProfileStore,
  ) : assert(_appConfiguration != null && _appStateUseCase != null) {
    _init();
  }

  _init() async {
    final authorizationStatus = await _appConfiguration.authorizationStatus;
    switch (authorizationStatus) {
      case AuthorizationStatus.authenticated:
        await _validateAppStates();
        break;
      case AuthorizationStatus.anonymous:
        _forwardToAuthentication();
    }
  }

  Future<void> _validateAppStates() async {
    final appState = await _appStateUseCase.check();
    appState.fold(
      (failure) => _handleFailure(failure),
      (state) => _handleAppStates(state),
    );
  }

  void _forwardToAuthenticated() async {
    final profile = await _userProfileStore.retrieve();

    if (profile.stealthModeEnabled) {
      Modular.to.pushReplacementNamed('/authentication/stealth');
      return;
    }

    if (profile.anonymousModeEnabled) {
      Modular.to.pushReplacementNamed('/authentication/sign_in_stealth');
      return;
    }

    Navigator.popAndPushNamed(Route('/mainboard?page=feed'));
  }

  void _forwardToAuthentication() {
    Modular.to.pushReplacementNamed('/authentication');
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerSideSessionFailed) {
      _forwardToAuthentication();
    } else {
      _forwardToAuthenticated();
    }
  }

  void _handleAppStates(AppStateEntity session) {
    if (session.quizSession != null &&
        session.quizSession.isFinished == false) {
      Modular.to.popAndPushNamed('/quiz', arguments: session.quizSession);
      return;
    }

    _forwardToAuthenticated();
  }
}
