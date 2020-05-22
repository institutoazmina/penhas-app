import 'package:flutter/material.dart';
import 'package:penhas/app/features/quiz/presentation/quiz/quiz_typedef.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/tutorial_page.dart';
import 'package:penhas/app/features/quiz/presentation/tutorial/tutorial_scale_route.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class QuizShowTutorialWidget extends StatelessWidget {
  final String reference;
  final UserReaction onPressed;

  const QuizShowTutorialWidget({
    Key key,
    @required this.reference,
    @required this.onPressed,
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
            TutorialScaleRoute(page: TutorialPage()),
          ).whenComplete(() => onPressed({reference: '1'}));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          "Ver tutorial",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
