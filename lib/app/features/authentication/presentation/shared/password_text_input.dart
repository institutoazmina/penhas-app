import 'package:flutter/material.dart';

import '../../../../shared/design_system/text_styles.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    this.style = kTextStyleDefaultTextFieldLabelStyle,
    this.isAutofocus = false,
    required this.onChanged,
    required this.labelText,
    required this.errorText,
    required this.hintText,
  });

  final TextStyle style;
  final void Function(String) onChanged;
  final String labelText;
  final String errorText;
  final String hintText;
  final bool isAutofocus;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  _PasswordInputFieldState();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: widget.style,
      autofocus: widget.isAutofocus,
      onChanged: widget.onChanged,
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70)),
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: kTextStyleDefaultTextFieldLabelStyle,
        hintText: widget.hintText,
        hintStyle: kTextStyleDefaultTextFieldLabelStyle,
        errorText: _normalizeHitText(widget.errorText),
        contentPadding: const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: _togglePassword,
        ),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? _normalizeHitText(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    return text;
  }
}
