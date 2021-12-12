import 'package:flutter/material.dart';
import 'package:penhas/app/features/zodiac/domain/entities/izodiac.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class ZodiacActionButton extends StatelessWidget {
  const ZodiacActionButton({
    required this.sign,
    required this.listOfSign,
    required this.isRunning,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IZodiac sign;
  final List<IZodiac> listOfSign;
  final VoidCallback onPressed;
  final bool isRunning;

  const ZodiacActionButton({
    required this.sign,
    required this.listOfSign,
    required this.isRunning,
    required this.onPressed,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listOfSign.length < 7) {
      return Container();
    }

    return SizedBox(
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
            onPressed: () {},
            onLongPress: onPressed,
            color: isRunning
                ? DesignSystemColors.pinky
                : DesignSystemColors.bluishPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isRunning ? 12 : 20),
            ),
            child: sign.icone,
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
