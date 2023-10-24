import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'Lato'),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        backgroundColor: Colors.transparent,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: DesignSystemColors.easterPurple,
        elevation: 0.0,
      ),
    );
  }
}
