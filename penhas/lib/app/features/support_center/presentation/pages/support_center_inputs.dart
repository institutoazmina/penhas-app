import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:penhas/app/shared/design_system/colors.dart';


class SupportCenterInputCep extends StatelessWidget {
  const SupportCenterInputCep({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.onChanged,
    required this.mask,
  }) : super(key: key);

  final String hintText;
  final String errorText;
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
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        maxLength: 9,
        inputFormatters: mask,
      ),
    );
  }
}

class SupportCenterInputDdd extends StatelessWidget {
  const SupportCenterInputDdd({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.onChanged,
    required this.mask,
  }) : super(key: key);

  final String hintText;
  final String errorText;
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
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        maxLength: 3,
      ),
    );
  }
}



class SupportCenterInputPhone extends StatelessWidget {
  const SupportCenterInputPhone({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.onChanged,
    required this.mask,
  }) : super(key: key);

  final String hintText;
  final String errorText;
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
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        maxLength: 11,
      ),
    );
  }
}
