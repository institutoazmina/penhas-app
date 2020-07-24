import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/error/failures.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/appstate/domain/usecases/app_state_usecase.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    @required IAppConfiguration appConfiguration,
    @required AppStateUseCase appStateUseCase,
  }) : super(appConfiguration, appStateUseCase);
}

abstract class _SplashControllerBase with Store {
  final AppStateUseCase _appStateUseCase;
  final IAppConfiguration _appConfiguration;

  _SplashControllerBase(
    this._appConfiguration,
    this._appStateUseCase,
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
        _forwardToAnonymous();
    }
  }

  Future<void> _validateAppStates() async {
    final appState = await _appStateUseCase.check();
    appState.fold(
      (failure) => _handleFailure(failure),
      (state) => _handleAppStates(state),
    );
  }

  void _forwardToAuthenticated() {
    Modular.to.popAndPushNamed('/mainboard');
  }

  void _forwardToAnonymous() {
    Modular.to.pushReplacementNamed('/authentication');
  }

  void _handleFailure(Failure failure) {
    if (failure is ServerSideSessionFailed) {
      _forwardToAnonymous();
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
