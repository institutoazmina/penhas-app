import 'package:flutter/material.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ZodiacActionButton extends StatelessWidget {
  final IZodiac sign;
  final List<IZodiac> listOfSign;
  final VoidCallback onPressed;
  const ZodiacActionButton({
    @required this.sign,
    @required this.listOfSign,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listOfSign == null || listOfSign.length < 7) {
      return Container();
    }

    return Container(
      height: 44.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          listOfSign[0].icone,
          listOfSign[1].icone,
          listOfSign[2].icone,
          listOfSign[3].icone,
          FlatButton(
            child: sign.icone,
            onPressed: onPressed,
            color: DesignSystemColors.bluishPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          listOfSign[4].icone,
          listOfSign[5].icone,
          listOfSign[6].icone,
          listOfSign[7].icone,
        ],
      ),
    );
  }
}
