import 'package:flutter/material.dart';

import 'styles/flat_button_style.dart';
import 'styles/penhas_button_style.dart';
import 'styles/rounded_button_style.dart';
import 'styles/text_button_style.dart';

class PenhasButton extends ElevatedButton {
  PenhasButton({
    Key? key,
    required VoidCallback? onPressed,
    required Widget? child,
    required PenhasButtonStyle style,
    FocusNode? focusNode,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: child,
          style: style.buttonStyle,
          focusNode: focusNode,
        );

  factory PenhasButton.roundedButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: RoundedButtonStyle(),
    );
  }

  factory PenhasButton.textButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: TextButtonStyle(),
    );
  }

  factory PenhasButton.flatButton({
    Key? key,
    required Widget? child,
    required VoidCallback? onPressed,
    FocusNode? focusNode,
  }) {
    return PenhasButton(
      child: child,
      onPressed: onPressed,
      focusNode: focusNode,
      style: FlatButtonStyle(),
    );
  }
}
