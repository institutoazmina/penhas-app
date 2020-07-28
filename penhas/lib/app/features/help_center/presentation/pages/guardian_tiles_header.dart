import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class GuardianTilesHeader extends StatelessWidget {
  final String title;
  const GuardianTilesHeader({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: DesignSystemColors.darkIndigoThree,
          fontSize: 20.0,
          letterSpacing: 0.65,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
