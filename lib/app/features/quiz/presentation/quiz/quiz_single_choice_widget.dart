import 'package:flutter/material.dart';

import '../../../../shared/design_system/button_shape.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../appstate/domain/entities/app_state_entity.dart';
import 'quiz_typedef.dart';

class QuizSingleChoiceWidget extends StatefulWidget {
  const QuizSingleChoiceWidget({
    Key? key,
    required this.reference,
    required this.onPressed,
    required this.options,
  }) : super(key: key);

  final String reference;
  final UserReaction onPressed;
  final List<QuizMessageChoiceOption> options;

  @override
  _QuizSingleChoiceWidgetState createState() => _QuizSingleChoiceWidgetState();
}

class _QuizSingleChoiceWidgetState extends State<QuizSingleChoiceWidget> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: DesignSystemColors.blueyGrey,
            offset: Offset(0.0, 2.0),
            blurRadius: 8.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxHeight: 208),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTileTheme(
                      contentPadding: EdgeInsets.zero,
                      child: ListBody(
                        children: widget.options.map(_buildItem).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    elevation: 0.0,
                    shape: kButtonShapeFilled,
                    color: DesignSystemColors.ligthPurple,
                    onPressed:
                        _selectedValue != null ? () => _onSavePressed() : null,
                    child: const Text(
                      'Enviar',
                      style: kTextStyleDefaultFilledButtonLabel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSavePressed() {
    final response = {
      widget.reference: _selectedValue!,
    };

    widget.onPressed(response);
  }

  Widget _buildItem(QuizMessageChoiceOption option) {
    return SizedBox(
      height: 44.0,
      child: RadioListTile(
        onChanged: (v) => _onItemCheckedChange(option.index, v == option.index),
        title: Text(option.display),
        value: option.index,
        groupValue: _selectedValue,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  void _onItemCheckedChange(String? itemValue, bool isChecked) {
    if (!isChecked) return;
    setState(() {
      _selectedValue = itemValue;
    });
  }
}
