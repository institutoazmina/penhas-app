import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';

String? _normalizeHitText(String? text) {
  if (text == null || text.isEmpty) {
    return null;
  }

  return text;
}

class WhiteBoxDecorationStyle extends InputDecoration {
  WhiteBoxDecorationStyle({
    required String super.labelText,
    super.hintText,
    String? errorText,
  }) : super(
          border: const OutlineInputBorder(),
          labelStyle: kTextStyleDefaultTextFieldLabelStyle,
          hintStyle: kTextStyleDefaultTextFieldLabelStyle,
          errorText: _normalizeHitText(errorText),
          contentPadding:
              const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        );
}

class PurpleBoxDecorationStyle extends InputDecoration {
  PurpleBoxDecorationStyle({
    required String super.labelText,
    super.hintText,
    String? errorText,
  }) : super(
          border: const OutlineInputBorder(),
          labelStyle: kTextStyleGreyDefaultTextFieldLabelStyle,
          hintStyle: kTextStyleGreyDefaultTextFieldLabelStyle,
          errorText: _normalizeHitText(errorText),
          contentPadding:
              const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.easterPurple),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.easterPurple),
          ),
        );
}
