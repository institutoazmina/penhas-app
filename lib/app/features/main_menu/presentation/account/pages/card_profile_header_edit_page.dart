import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/design_system/colors.dart';

class CardProfileHeaderEditPage extends StatelessWidget {
  const CardProfileHeaderEditPage({
    Key? key,
    required this.title,
    required this.onEditAction,
  }) : super(key: key);

  final String title;
  final void Function()? onEditAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: cardTitleTextStyle),
        if (onEditAction == null)
          Container()
        else
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/svg/profile/edit.svg',
              colorFilter: const ColorFilter.mode(
                  DesignSystemColors.pinky, BlendMode.color),
            ),
            onPressed: onEditAction,
          ),
      ],
    );
  }
}

extension _TextStyle on CardProfileHeaderEditPage {
  TextStyle get cardTitleTextStyle => const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}
