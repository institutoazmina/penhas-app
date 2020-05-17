import 'package:flutter/material.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ButtonYesNoWidget extends StatelessWidget {
  final String reference;
  final UserReaction onPressed;

  const ButtonYesNoWidget({
    Key key,
    @required this.reference,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final horizontalMargin = 24.0;
    final buttonWidthSize =
        (MediaQuery.of(context).size.width - ((horizontalMargin * 2) + 36)) / 2;
    return Container(
      padding: EdgeInsets.fromLTRB(
        horizontalMargin,
        4.0,
        horizontalMargin,
        4.0,
      ),
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildActionButton(
              width: buttonWidthSize,
              title: 'SIM',
              actionResponse: {reference: '1'},
              onPressed: onPressed),
          _buildActionButton(
              width: buttonWidthSize,
              title: 'NÃO',
              actionResponse: {reference: '0'},
              onPressed: onPressed)
        ],
      ),
    );
  }

  SizedBox _buildActionButton({
    @required double width,
    @required String title,
    @required Map<String, String> actionResponse,
    @required UserReaction onPressed,
  }) {
    return SizedBox(
      width: width,
      height: 40.0,
      child: RaisedButton(
        onPressed: () => onPressed(actionResponse),
        elevation: 0.0,
        color: Colors.white,
        child: Text(
          title,
          style: TextStyle(
            color: DesignSystemColors.ligthPurple,
            fontSize: 14.0,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: DesignSystemColors.ligthPurple),
        ),
      ),
    );
  }
}
