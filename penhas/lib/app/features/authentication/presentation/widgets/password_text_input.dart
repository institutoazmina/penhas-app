import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class PassordInputField extends StatefulWidget {
  final TextStyle style;
  final void Function(String) onChanged;
  final String labelText;
  final String errorText;
  final String hintText;

  PassordInputField({
    Key key,
    this.style = kDefaultTextFieldLabelStyle,
    @required this.onChanged,
    @required this.labelText,
    @required this.errorText,
    @required this.hintText,
  }) : super(key: key);

  @override
  _PassordInputFieldState createState() => _PassordInputFieldState();
}

class _PassordInputFieldState extends State<PassordInputField> {
  _PassordInputFieldState();

  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      style: widget.style,
      onChanged: widget.onChanged,
      autocorrect: false,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        labelStyle: kDefaultTextFieldLabelStyle,
        hintText: widget.hintText,
        hintStyle: kDefaultTextFieldLabelStyle,
        errorText: _normalizeHitText(widget.errorText),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        suffixIcon: IconButton(
          icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white70),
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

  String _normalizeHitText(String text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    return text;
  }
}
