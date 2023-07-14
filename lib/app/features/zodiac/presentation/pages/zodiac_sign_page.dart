import 'package:flutter/material.dart';

import '../../../../shared/design_system/text_styles.dart';
import '../../domain/entities/izodiac.dart';

class ZodiacSignPage extends StatelessWidget {
  const ZodiacSignPage({
    required this.sign,
    Key? key,
  }) : super(key: key);

  final IZodiac sign;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: sign.constelation,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            sign.name,
            style: kTextStyleZodiacTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
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
