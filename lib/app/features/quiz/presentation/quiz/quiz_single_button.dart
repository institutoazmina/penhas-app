import 'package:flutter/material.dart';

import '../../../../shared/design_system/button_shape.dart';
import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/text_styles.dart';
import 'quiz_typedef.dart';

class QuizSingleButtonWidget extends StatelessWidget {
  const QuizSingleButtonWidget({
    Key? key,
    required this.reference,
    required this.onPressed,
    required this.buttonLabel,
  }) : super(key: key);

  final String reference;
  final String? buttonLabel;
  final UserReaction onPressed;

  @override
  Widget build(BuildContext context) {
    const double horizontalMargin = 24.0;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        horizontalMargin,
        4.0,
        horizontalMargin,
        4.0,
      ),
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: DesignSystemColors.ligthPurple,
        elevation: 0.0,
        onPressed: () => onPressed({reference: '1'}),
        shape: kButtonShapeFilled,
        child: Text(
          buttonLabel!,
          style: kTextStyleDefaultFilledButtonLabel,
        ),
      ),
    );
  }
}
