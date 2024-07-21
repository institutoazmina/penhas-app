part of '../styles.dart';

typedef FilledButton = ElevatedButton;

class FilledButtonStyle extends ButtonStyle {
  const FilledButtonStyle._();

  static ButtonStyle raised({
    Color color = DesignSystemColors.ligthPurple,
    Color? disabledColor = DesignSystemColors.disabledColor,
    Color textColor = Colors.white,
    double? elevation = 0.0,
    Size? minimumSize = const Size(88.0, 36.0),
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16.0),
    OutlinedBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  }) =>
      ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) =>
              states.contains(MaterialState.disabled) ? disabledColor : color,
        ),
        elevation: ButtonStyleButton.allOrNull(elevation),
        padding: ButtonStyleButton.allOrNull(padding),
        minimumSize: ButtonStyleButton.allOrNull(minimumSize),
        shape: ButtonStyleButton.allOrNull(shape),
      );

  static ElevatedButtonThemeData theme() => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(),
      );
}
