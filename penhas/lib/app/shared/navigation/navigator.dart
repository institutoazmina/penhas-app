import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart' as material;

import 'route.dart';

class AppNavigator {
  static void popAndPush(AppRoute route) {
    if (route.args == null) {
      Modular.to.popAndPushNamed(route.path);
    } else {
      Modular.to.popAndPushNamed(route.path, arguments: route.args);
    }
  }

  static void push(AppRoute route) {
    if (route.args == null) {
      Modular.to.pushNamed(route.path);
    } else {
      Modular.to.pushNamed(route.path, arguments: route.args);
    }
  }

  static void pushAndRemoveUntil(AppRoute route,
      {@required String removeUntil}) {
    if (route.args == null) {
      Modular.to.pushNamedAndRemoveUntil(
        route.path,
        material.ModalRoute.withName(removeUntil),
      );
    } else {
      Modular.to.pushNamedAndRemoveUntil(
        route.path,
        material.ModalRoute.withName(removeUntil),
        arguments: route.args,
      );
    }
  }
}
