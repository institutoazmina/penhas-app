import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import 'quiz_typedef.dart';

class QuizButtonYesNoWidget extends StatelessWidget {
  const QuizButtonYesNoWidget({
    Key? key,
    required this.reference,
    required this.onPressed,
  }) : super(key: key);

  final String reference;
  final UserReaction onPressed;

  @override
  Widget build(BuildContext context) {
    const horizontalMargin = 24.0;
    final buttonWidthSize =
        (MediaQuery.of(context).size.width - ((horizontalMargin * 2) + 36)) / 2;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        horizontalMargin,
        4.0,
        horizontalMargin,
        4.0,
      ),
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildActionButton(
            width: buttonWidthSize,
            title: 'SIM',
            actionResponse: {reference: 'Y'},
            onPressed: onPressed,
          ),
          _buildActionButton(
            width: buttonWidthSize,
            title: 'NÃO',
            actionResponse: {reference: 'N'},
            onPressed: onPressed,
          )
        ],
      ),
    );
  }

  SizedBox _buildActionButton({
    required double width,
    required String title,
    required Map<String, String> actionResponse,
    required UserReaction onPressed,
  }) {
    return SizedBox(
      width: width,
      height: 40.0,
      child: RaisedButton(
        onPressed: () => onPressed(actionResponse),
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: DesignSystemColors.ligthPurple),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: DesignSystemColors.ligthPurple,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
