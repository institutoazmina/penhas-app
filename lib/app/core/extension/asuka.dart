import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/design_system/colors.dart';

extension Dialog on IModularNavigator {
  Future<T?> showDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) =>
      Asuka.showDialog<T>(
        builder: builder,
        barrierDismissible: barrierDismissible,
        barrierColor: DesignSystemColors.dialogBarrierColor,
      );
}
