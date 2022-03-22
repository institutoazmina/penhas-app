import 'package:flutter/material.dart' as material;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/logger/log.dart';
import 'package:penhas/app/shared/navigation/route.dart';

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

  static Future<void> pushAndRemoveUntil(
    AppRoute route, {
    required String removeUntil,
  }) async {
    await popUntil(material.ModalRoute.withName(removeUntil)).then(
      (lastPath) async {
        if (route.path == lastPath) {
          return null;
        }
        if (removeUntil != lastPath) {
          return Modular.to.pushReplacementNamed(
            route.path,
            arguments: route.args,
          );
        }
        return Modular.to.pushNamed(route.path, arguments: route.args);
      },
    ).catchError(catchErrorLogger);
  }

  static Future<String?> popUntil(material.RoutePredicate predicate) async {
    material.Route? lastRoute;
    Modular.to.popUntil(
      (route) {
        lastRoute = lastRoute ?? route;
        return !route.willHandlePopInternally &&
            (!Modular.to.canPop() || predicate(route));
      },
    );
    return lastRoute?.settings.name;
  }
}
