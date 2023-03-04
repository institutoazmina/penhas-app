import 'package:flutter/material.dart';

const Duration _defaultSnackBarDuration = Duration(seconds: 4);

mixin SnackBarHandler {
  void showSnackBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String? message,
    Duration duration = _defaultSnackBarDuration,
  }) {
    final context = scaffoldKey.currentContext;
    if (message == null || message.isEmpty || context == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
