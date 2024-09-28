import 'package:flutter/material.dart';

import 'buttons/styles.dart';

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'Lato'),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        backgroundColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonStyle.theme(),
      elevatedButtonTheme: FilledButtonStyle.theme(),
      outlinedButtonTheme: OutlinedButtonStyle.theme(),
    );
  }
}
