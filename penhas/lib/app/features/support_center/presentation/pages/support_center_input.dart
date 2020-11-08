import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterInput extends StatelessWidget {
  final int maxLines;
  final String hintText;
  final String errorText;
  final ValueChanged<String> onChanged;

  const SupportCenterInput({
    Key key,
    this.maxLines = 1,
    @required this.hintText,
    @required this.errorText,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
          errorText: errorText.isEmpty ? null : errorText,
        ),
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.streetAddress,
        onChanged: onChanged,
      ),
    );
  }
}
