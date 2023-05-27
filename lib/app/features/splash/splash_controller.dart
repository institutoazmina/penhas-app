import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/data/authorization_status.dart';
import '../../core/error/failures.dart';
import '../../core/managers/app_configuration.dart';
import '../../core/managers/local_store.dart';
import '../../shared/navigation/app_navigator.dart';
import '../../shared/navigation/app_route.dart';
import '../appstate/domain/entities/app_state_entity.dart';
import '../appstate/domain/entities/user_profile_entity.dart';
import '../appstate/domain/usecases/app_state_usecase.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    required IAppConfiguration appConfiguration,
    required AppStateUseCase appStateUseCase,
    required LocalStore<UserProfileEntity> userProfileStore,
  }) : super(appConfiguration, appStateUseCase, userProfileStore);
}

abstract class _SplashControllerBase with Store {
  _SplashControllerBase(
    this._appConfiguration,
    this._appStateUseCase,
    this._userProfileStore,
  );

  final AppStateUseCase _appStateUseCase;
  final IAppConfiguration _appConfiguration;
  final LocalStore<UserProfileEntity> _userProfileStore;

  Future init() async {
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

  Future<void> _forwardToAuthenticated() async {
    final profile = await _userProfileStore.retrieve();

    if (profile.stealthModeEnabled) {
      Modular.to.pushReplacementNamed('/authentication/stealth');
      return;
    }

    if (profile.anonymousModeEnabled) {
      Modular.to.pushReplacementNamed('/authentication/sign_in_stealth');
      return;
    }

    AppNavigator.popAndPush(AppRoute('/mainboard?page=feed'));
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
        session.quizSession!.isFinished == false) {
      Modular.to.popAndPushNamed('/quiz', arguments: session.quizSession);
      return;
    }

    _forwardToAuthenticated();
  }
}
