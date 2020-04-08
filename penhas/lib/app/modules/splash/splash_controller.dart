import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  _SplashControllerBase() {
    autorun((_) {
      return Future.delayed(Duration(seconds: 1), () {
        Modular.to.pushReplacementNamed('/authentication');
      });
    });
  }
}
