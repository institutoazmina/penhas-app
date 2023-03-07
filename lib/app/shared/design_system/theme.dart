import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'Lato'),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
