import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/design_system/text_styles.dart';

class SingleTextInput extends StatelessWidget {
  const SingleTextInput({
    super.key,
    TextInputFormatter? inputFormatter,
    TextInputType keyboardType = TextInputType.text,
    TextStyle style = kTextStyleDefaultTextFieldLabelStyle,
    required onChanged,
    required InputDecoration boxDecoration,
  })  : _keyboardType = keyboardType,
        _style = style,
        _onChanged = onChanged,
        _inputFormatter = inputFormatter,
        _boxDecoration = boxDecoration;

  final TextInputType _keyboardType;
  final TextStyle _style;
  final void Function(String) _onChanged;
  final TextInputFormatter? _inputFormatter;
  final InputDecoration _boxDecoration;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('singleTextInput'),
      style: _style,
      keyboardType: _keyboardType,
      inputFormatters: _inputFormatter == null ? null : [_inputFormatter],
      onChanged: _onChanged,
      decoration: _boxDecoration,
    );
  }
}
