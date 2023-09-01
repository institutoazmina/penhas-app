import 'package:flutter/widgets.dart';

class PenhasTextStyle {
  PenhasTextStyle._();

  static const String _fontFamily = 'Lato';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 64 / 57,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 52 / 45,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 44 / 36,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 40 / 32,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 36 / 28,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 32 / 24,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    height: 28 / 22,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.15,
    height: 24 / 16,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.1,
    height: 20 / 14,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.1,
    height: 20 / 14,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    letterSpacing: 0.5,
    height: 16 / 12,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.medium,
    height: 16 / 11,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    letterSpacing: 0.5,
    height: 24 / 16,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontFamily: _fontFamily,
    fontStyle: FontStyle.normal,
    fontWeight: _PenhasFontWeight.regular,
    letterSpacing: 0.25,
    height: 20 / 14,
  );

  static const TextStyle bodySmall = TextStyle(
      fontSize: 12,
      fontFamily: _fontFamily,
      fontStyle: FontStyle.normal,
      fontWeight: _PenhasFontWeight.regular,
      letterSpacing: 0.4,
      height: 16 / 12);
}

class _PenhasFontWeight {
  static const FontWeight bold = FontWeight.w900;
  static const FontWeight medium = FontWeight.w700;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight light = FontWeight.w300;
}
