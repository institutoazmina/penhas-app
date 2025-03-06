part of '../styles.dart';

class TextButtonStyle extends ButtonStyle {
  const TextButtonStyle._();

  static ButtonStyle flat({
    Color? color = Colors.black87,
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16.0),
    Size? minimumSize = const Size(88.0, 36.0),
    OutlinedBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  }) =>
      TextButton.styleFrom(
        foregroundColor: color,
        padding: padding,
        minimumSize: minimumSize,
        shape: shape,
      );

  static TextButtonThemeData theme() => TextButtonThemeData(
        style: TextButton.styleFrom(),
      );
}
