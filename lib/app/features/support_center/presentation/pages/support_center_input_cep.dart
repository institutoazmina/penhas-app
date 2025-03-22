import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../shared/design_system/colors.dart';

class SupportCenterInputCep extends StatelessWidget {
  const SupportCenterInputCep({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.mask,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final List<MaskTextInputFormatter> mask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        maxLength: 9,
        inputFormatters: mask,
      ),
    );
  }
}
