import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';
import '../../domain/entities/izodiac.dart';

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
          listOfSign[0].icon,
          listOfSign[1].icon,
          listOfSign[2].icon,
          listOfSign[3].icon,
          SizedBox(
            width: 70.0,
            child: TextButton(
              key: const Key('zodiac_action_button'),
              onPressed: () {},
              onLongPress: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: isRunning
                    ? DesignSystemColors.pinky
                    : DesignSystemColors.bluishPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(isRunning ? 12 : 20),
                ),
              ),
              child: sign.icon,
            ),
          ),
          listOfSign[4].icon,
          listOfSign[5].icon,
          listOfSign[6].icon,
          listOfSign[7].icon,
        ],
      ),
    );
  }
}
