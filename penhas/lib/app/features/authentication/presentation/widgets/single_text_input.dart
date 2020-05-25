import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class SingleTextInput extends StatelessWidget {
  final TextInputType _keyboardType;
  final TextStyle _style;
  final void Function(String) _onChanged;
  final String _labelText;
  final String _errorText;
  final String _hintText;

  const SingleTextInput({
    Key key,
    keyboardType = TextInputType.text,
    style = kDefaultTextFieldLabelStyle,
    @required labelText,
    @required errorText,
    @required hintText,
    @required onChanged,
  })  : this._keyboardType = keyboardType,
        this._style = style,
        this._onChanged = onChanged,
        this._labelText = labelText,
        this._errorText = errorText,
        this._hintText = hintText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: _keyboardType,
      style: _style,
      onChanged: _onChanged,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: _labelText,
        labelStyle: kDefaultTextFieldLabelStyle,
        errorText: _normalizeHitText(_errorText),
        hintText: _hintText,
        hintStyle: kDefaultTextFieldLabelStyle,
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        border: OutlineInputBorder(),
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
