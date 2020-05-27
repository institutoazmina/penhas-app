import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/repositories/i_app_state_repository.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    @required IAppConfiguration appConfiguration,
    @required IAppStateRepository appStateRepository,
  }) : super(appConfiguration, appStateRepository);
}

abstract class _SplashControllerBase with Store {
  final IAppConfiguration _appConfiguration;
  final IAppStateRepository _appStateRepository;

  _SplashControllerBase(
    this._appConfiguration,
    this._appStateRepository,
  ) : assert(_appConfiguration != null && _appStateRepository != null) {
    _init();
  }

  _init() async {
    final authorizationStatus = await _appConfiguration.authorizationStatus;
    switch (authorizationStatus) {
      case AuthorizationStatus.authenticated:
        await _validateAppStates();
        break;
      case AuthorizationStatus.anonymous:
        _forwardToAnonymous();
    }
  }

  Future<void> _validateAppStates() async {
    final appState = await _appStateRepository.check();
    appState.fold(
      (failure) => _handleFailure(failure),
      (state) => _handleAppStates(state),
    );
  }

  void _forwardToAuthenticated() {
    Modular.to.popAndPushNamed('/mainboard');
  }

  void _forwardToAnonymous() {
    Modular.to.popAndPushNamed('/authentication');
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerSideSessionFailed) {
      _forwardToAnonymous();
    } else {
      _forwardToAuthenticated();
    }
  }

  void _handleAppStates(AppStateEntity session) {
    if (session.quizSession != null ||
        session.quizSession.isFinished == false) {
      Modular.to.popAndPushNamed('/quiz', arguments: session.quizSession);
      return;
    }

    _forwardToAuthenticated();
  }
}
