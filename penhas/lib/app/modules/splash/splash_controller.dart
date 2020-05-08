import 'package:meta/meta.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/data/authorization_status.dart';
import 'package:penhas/app/core/managers/app_configuration.dart';

part 'splash_controller.g.dart';

class SplashController extends _SplashControllerBase with _$SplashController {
  SplashController({
    @required IAppConfiguration appConfiguration,
  }) : super(appConfiguration);
}

abstract class _SplashControllerBase with Store {
  final IAppConfiguration _appConfiguration;

  _SplashControllerBase(this._appConfiguration) {
    _init();
  }

  _init() async {
    final authorizationStatus = await _appConfiguration.authorizationStatus;
    switch (authorizationStatus) {
      case AuthorizationStatus.authenticated:
        _forwardToAuthenticated();
        break;
      case AuthorizationStatus.anonymous:
        _forwardToAnonymous();
    }
  }

  void _forwardToAuthenticated() {
    Modular.to.pushReplacementNamed('/mainboard');
  }

  void _forwardToAnonymous() {
    Modular.to.pushReplacementNamed('/authentication');
  }
}
