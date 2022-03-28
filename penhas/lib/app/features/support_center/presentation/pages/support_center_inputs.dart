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
        inputFormatters: mask,
      ),
    );
  }
}

class SupportCenterInputPhone extends StatelessWidget {
  SupportCenterInputPhone({
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
        inputFormatters: mask,
      ),
    );
  }
}

class DynamicMaskPhoneFormatter extends MaskTextInputFormatter {

  DynamicMaskPhoneFormatter({String initialText = ''})
      : super(
          mask: '####-####',
          filter: {'#': RegExp('[0-9]')},
          initialText: initialText,
        );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,) {
    if (newValue.text.length < 9) {
      updateMask(mask: '####-####');
    }else if (newValue.text.length < 10) {
      updateMask(mask: '#####-####');
    } else{
      updateMask(mask: '#### ### ###');
    }

    return super.formatEditUpdate(oldValue, newValue);
  }
}
