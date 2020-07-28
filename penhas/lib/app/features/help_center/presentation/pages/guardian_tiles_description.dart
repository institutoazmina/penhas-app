import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class GuardianTilesDescription extends StatelessWidget {
  final String description;
  const GuardianTilesDescription({
    Key key,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          description,
          style: TextStyle(
            color: DesignSystemColors.darkIndigoThree,
            fontSize: 14.0,
            letterSpacing: 0.45,
            fontFamily: 'Lato',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
