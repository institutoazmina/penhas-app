import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class SingleTextInput extends StatelessWidget {
  final TextInputType _keyboardType;
  final TextStyle _style;
  final void Function(String) _onChanged;
  final String _labelText;
  final String _errorText;
  final String _hintText;
  final TextInputFormatter _inputFormatter;

  const SingleTextInput({
    Key key,
    String hintText,
    TextInputFormatter inputFormatter,
    TextInputType keyboardType = TextInputType.text,
    TextStyle style = kDefaultTextFieldLabelStyle,
    @required String labelText,
    @required String errorText,
    @required onChanged,
  })  : this._keyboardType = keyboardType,
        this._style = style,
        this._onChanged = onChanged,
        this._labelText = labelText,
        this._errorText = errorText,
        this._hintText = hintText,
        this._inputFormatter = inputFormatter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: _style,
      keyboardType: _keyboardType,
      inputFormatters: _inputFormatter == null ? null : [_inputFormatter],
      onChanged: _onChanged,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        border: OutlineInputBorder(),
        labelText: _labelText,
        labelStyle: kDefaultTextFieldLabelStyle,
        hintText: _hintText,
        hintStyle: kDefaultTextFieldLabelStyle,
        errorText: _normalizeHitText(_errorText),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
      ),
    );
  }

  String _normalizeHitText(String text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    return text;
  }
}
