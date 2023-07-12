import 'package:flutter/material.dart';

const Duration _defaultSnackBarDuration = Duration(seconds: 4);

mixin SnackBarHandler {
  void showSnackBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String? message,
    Duration duration = _defaultSnackBarDuration,
  }) {
    if (message == null || message.isEmpty) {
      return;
    }

    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
