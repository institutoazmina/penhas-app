import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: 'Lato'),
      bottomSheetTheme: base.bottomSheetTheme.copyWith(
        backgroundColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          minimumSize: const Size(88.0, 36.0),
        ),
      ),
    );
  }
}
