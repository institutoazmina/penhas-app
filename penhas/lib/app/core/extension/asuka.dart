import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension Dialog on IModularNavigator {
  Future showDialog({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) async {
    asuka.showDialog(builder: builder, barrierDismissible: barrierDismissible);
  }
}
