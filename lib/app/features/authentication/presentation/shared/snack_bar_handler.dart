import 'package:flutter/material.dart';

const Duration _defaultSnackBarDuration = Duration(seconds: 4);

mixin SnackBarHandler {
  void showSnackBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String? message,
    Duration? duration,
  }) {
    if (message == null || message.isEmpty) {
      return;
    }

    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? _defaultSnackBarDuration,
      ),
    );
  }
}
