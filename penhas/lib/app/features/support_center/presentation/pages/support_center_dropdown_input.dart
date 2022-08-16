import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterDropdownInput extends StatelessWidget {
  const SupportCenterDropdownInput({
    Key? key,
    this.maxLines = 1,
    required this.labelText,
    required this.errorMessage,
    required this.currentValue,
    required this.dataSource,
    required this.onChanged,
    this.focus = false,
  }) : super(key: key);

  final int maxLines;
  final String labelText;
  final String errorMessage;
  final String currentValue;
  final bool focus;
  final List<DropdownMenuItem<String>> dataSource;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return buildUF(
      context,
      labelText,
      errorMessage,
      onChanged,
      currentValue,
      dataSource,
    );
  }

  Widget buildUF<T>(
    BuildContext context,
    String labelText,
    String? errorMessage,
    dynamic onChanged,
    T currentValue,
    List dataSource,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(canvasColor: const Color.fromRGBO(240, 240, 240, 1)),
        child: DropdownButtonFormField<dynamic>(
          autofocus: focus,
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            errorText: (errorMessage?.isEmpty ?? true) ? null : errorMessage,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: DesignSystemColors.easterPurple),
            ),
            contentPadding:
                const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
            hintText: labelText,
            hintStyle: const TextStyle(color: Colors.black),
          ),
          items: dataSource as List<DropdownMenuItem>,
          onChanged: onChanged,
          value: currentValue == '' ? null : currentValue,
        ),
      ),
    );
  }
}
