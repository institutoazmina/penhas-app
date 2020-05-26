import 'package:flutter/material.dart';

mixin SnackBarHandler {
  void showSnackBar(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required String message}) {
    if (message == null || message.isEmpty) {
      return;
    }

    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
