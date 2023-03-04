import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
