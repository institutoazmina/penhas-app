import 'package:flutter/material.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ZodiacSignPage extends StatelessWidget {
  final IZodiac sign;
  const ZodiacSignPage({
    @required this.sign,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: sign.constelation,
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            sign.name,
            style: kTextStyleZodiacTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Text(
            sign.date,
            style: kTextStyleGuardianBodyTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
