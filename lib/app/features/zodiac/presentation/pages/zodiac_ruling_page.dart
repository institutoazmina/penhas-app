import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/design_system/text_styles.dart';

class ZodiacRulingPage extends StatelessWidget {
  const ZodiacRulingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/images/zodiac/svg/sun.svg'),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text('Sol'),
            )
          ],
        ),
        Row(
          children: [
            SvgPicture.asset('assets/images/zodiac/svg/moon.svg'),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                'Lua',
                style: kTextStyleZodiacRulling,
              ),
            )
          ],
        ),
        Row(
          children: [
            SvgPicture.asset('assets/images/zodiac/svg/venus.svg'),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                'Vênus',
                style: kTextStyleZodiacRulling,
              ),
            )
          ],
        )
      ],
    );
  }
}
