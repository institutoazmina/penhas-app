import 'package:flutter/material.dart' as material;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logger/log.dart';
import 'app_route.dart';

class AppNavigator {
  static void popAndPush(AppRoute route) {
    Modular.to.popAndPushNamed(route.path, arguments: route.args);
  }

  static void push(AppRoute route) {
    Modular.to.pushNamed(route.path, arguments: route.args);
  }

  static void tryPopOrPushReplacement(AppRoute route) {
    if (Modular.to.canPop()) {
      Modular.to.pop();
    } else {
      Modular.to.pushReplacementNamed(route.path, arguments: route.args);
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

  static Future<void> launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await canLaunchUrl(uri)) {
        throw 'Can\'t launch url "$url"';
      }
      await launchUrl(uri);
    } catch (e, stack) {
      logError(e, stack);
    }
  }
}
