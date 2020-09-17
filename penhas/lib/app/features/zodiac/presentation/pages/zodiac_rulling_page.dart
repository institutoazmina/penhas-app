import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ZodiacRullingPage extends StatelessWidget {
  const ZodiacRullingPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Row(
            children: [
              SvgPicture.asset('assets/images/zodiac/svg/sun.svg'),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text('Sol'),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              SvgPicture.asset('assets/images/zodiac/svg/moon.svg'),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Lua',
                  style: kTextStyleZodiacRulling,
                ),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              SvgPicture.asset('assets/images/zodiac/svg/venus.svg'),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Vênus',
                  style: kTextStyleZodiacRulling,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
