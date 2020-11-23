import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class CardProfileHeaderEditPage extends StatelessWidget {
  final String title;
  final void Function() onEditAction;
  const CardProfileHeaderEditPage({
    Key key,
    @required this.title,
    @required this.onEditAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: cardTitleTextStyle),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/svg/profile/edit.svg',
              color: DesignSystemColors.pumpkinOrange,
            ),
            onPressed: onEditAction,
          ),
        ],
      ),
    );
  }
}

extension _TextStyle on CardProfileHeaderEditPage {
  TextStyle get cardTitleTextStyle => TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        letterSpacing: 0.63,
        color: DesignSystemColors.darkIndigoThree,
        fontWeight: FontWeight.bold,
      );
}
