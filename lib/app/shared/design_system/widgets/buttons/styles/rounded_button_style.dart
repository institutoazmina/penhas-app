import 'package:flutter/material.dart';

import '../../../styles/penhas_colors.dart';
import '../../../styles/penhas_text_style.dart';
import 'penhas_button_style.dart';

class RoundedButtonStyle implements PenhasButtonStyle {
  @override
  ButtonStyle get buttonStyle => ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(PenhasColors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(PenhasColors.lightPurple),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            side: BorderSide(color: PenhasColors.lightPurple),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(0.0),
        textStyle: MaterialStateProperty.all<TextStyle>(
            PenhasTextStyle.bodyMedium.copyWith(
          color: PenhasColors.white,
        )),
      );
}
