import 'package:flutter/material.dart';
import 'package:penhas/app/features/appstate/domain/entities/app_state_entity.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class QuizMultipleChoicesWidget extends StatefulWidget {
  final String reference;
  final UserReaction onPressed;
  final List<QuizMessageMultiplechoicesOptions> options;

  QuizMultipleChoicesWidget({
    Key key,
    @required this.reference,
    @required this.onPressed,
    @required this.options,
  }) : super(key: key);

  @override
  _QuizMultipleChoicesWidgetState createState() =>
      _QuizMultipleChoicesWidgetState();
}

class _QuizMultipleChoicesWidgetState extends State<QuizMultipleChoicesWidget> {
  final _selectedValues = List<String>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
        padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 8.0),
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 208),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListTileTheme(
                        contentPadding: EdgeInsets.zero,
                        child: ListBody(
                          children:
                              widget.options.map((e) => _buildItem(e)).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    elevation: 0.0,
                    shape: kButtonShapeFilled,
                    color: DesignSystemColors.ligthPurple,
                    onPressed: _selectedValues.length == 0
                        ? null
                        : () => _onSavePressed(),
                    child: Text(
                      'Enviar',
                      style: kDefaultFilledButtonLabel,
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
      widget.reference: _selectedValues.join(','),
    };

    widget.onPressed(response);
  }

  Widget _buildItem(QuizMessageMultiplechoicesOptions option) {
    final checked = _selectedValues.contains(option.index);

    return SizedBox(
      height: 44.0,
      child: CheckboxListTile(
          onChanged: (v) => _onItemCheckedChange(option.index, v),
          value: checked,
          title: Text(option.display),
          controlAffinity: ListTileControlAffinity.leading),
    );
  }

  void _onItemCheckedChange(String itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }
}
