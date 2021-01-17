import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart' as material;

import 'route.dart';

class Navigator {
  static void popAndPushNamed(Route route) {
    if (route.args == null) {
      Modular.to.popAndPushNamed(route.path);
    } else {
      Modular.to.popAndPushNamed(route.path, arguments: route.args);
    }
  }

  static void pushNamedAndRemoveUntil(Route route) {
    Modular.to.pushNamedAndRemoveUntil(
      '/authentication/stealth',
      material.ModalRoute.withName('/'),
    );
  }
}
