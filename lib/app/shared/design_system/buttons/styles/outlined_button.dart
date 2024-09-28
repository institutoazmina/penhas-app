part of '../styles.dart';

class OutlinedButtonStyle extends ButtonStyle {
  const OutlinedButtonStyle._();

  static ButtonStyle outline({
    Color color = DesignSystemColors.ligthPurple,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    Size minimumSize = const Size(88.0, 36.0),
    OutlinedBorder? shape,
    BorderSide? side,
  }) =>
      OutlinedButton.styleFrom(
        primary: color,
        padding: padding,
        minimumSize: minimumSize,
        shape: shape,
        side: side ?? shape?.side,
      );

  static OutlinedButtonThemeData theme() => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(),
      );
}
