import 'package:flutter/material.dart' as material;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logger/log.dart';
import 'app_route.dart';

class AppNavigator {
  const AppNavigator();

  static AppNavigator? _instance;

  static AppNavigator get instance => _instance ??= const AppNavigator();

  static void popAndPush(AppRoute route) {
    Modular.to.popAndPushNamed(route.path, arguments: route.args);
  }

  Future<T?> navigateTo<T extends Object?>(AppRoute route) =>
      Modular.to.pushNamed<T>(route.path, arguments: route.args);

  static void push(AppRoute route) {
    instance.navigateTo(route);
  }

  static void tryPopOrPushReplacement(AppRoute route) {
    if (Modular.to.canPop()) {
      Modular.to.pop();
    } else {
      Modular.to.pushReplacementNamed(route.path, arguments: route.args);
    }
  }

  Future<void> pushAndRemoveUntil(
    AppRoute route, {
    required String removeUntil,
  }) async {
    try {
      final lastPath =
          await popUntil(material.ModalRoute.withName(removeUntil));

      if (route.path == lastPath) {
        return Future.value();
      }

      if (removeUntil != lastPath) {
        await Modular.to.pushReplacementNamed(
          route.path,
          arguments: route.args,
        );

        return Future.value();
      }

      await Modular.to.pushNamed(route.path, arguments: route.args);
    } catch (error, stack) {
      logError(error, stack);
    }
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
