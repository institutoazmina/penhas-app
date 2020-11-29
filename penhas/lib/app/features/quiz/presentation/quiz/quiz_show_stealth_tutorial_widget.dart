import 'package:flutter/material.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/stealth_mode_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class QuizShowStealthTutorialWidget extends StatelessWidget {
  final String reference;
  final String buttonLabel;
  final UserReaction onPressed;

  const QuizShowStealthTutorialWidget({
    Key key,
    @required this.reference,
    @required this.onPressed,
    @required this.buttonLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double horizontalMargin = 24.0;

    return Container(
      padding: EdgeInsets.fromLTRB(
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
        onPressed: () async {
          await Navigator.push(
            context,
            TutorialScaleRoute(page: StealthModeTutorialPage()),
          ).then(
            (value) => onPressed({reference: value ? '1' : '0'}),
          );
        },
        shape: kButtonShapeFilled,
        child: Text(
          buttonLabel,
          style: kTextStyleDefaultFilledButtonLabel,
        ),
      ),
    );
  }
}
