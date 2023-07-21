import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';

class SupportCenterInput extends StatelessWidget {
  const SupportCenterInput({
    Key? key,
    this.maxLines = 1,
    required this.hintText,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final int maxLines;
  final String hintText;
  final String errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
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
          errorText: errorText.isEmpty ? null : errorText,
        ),
        keyboardType: TextInputType.streetAddress,
        onChanged: onChanged,
      ),
    );
  }
}
