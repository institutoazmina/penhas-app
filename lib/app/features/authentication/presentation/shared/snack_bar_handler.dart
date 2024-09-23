import 'package:flutter/material.dart';

const Duration _defaultSnackBarDuration = Duration(seconds: 4);

mixin SnackBarHandler {
  void showSnackBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String? message,
    Duration duration = _defaultSnackBarDuration,
  }) {
    if (message == null || message.isEmpty) return;

    scaffoldKey.messenger?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}

extension ScaffoldX on GlobalKey<ScaffoldState> {
  ScaffoldMessengerState? get messenger {
    final context = currentContext;
    assert(context != null);
    if (context == null) return null;
    return ScaffoldMessenger.of(context);
  }

  void hideCurrentSnackBar() {
    messenger?.hideCurrentSnackBar();
  }
}
