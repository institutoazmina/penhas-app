import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';

class GuardianTileHeader extends StatelessWidget {
  const GuardianTileHeader({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      alignment: Alignment.centerLeft,
      child: Text(
        title!,
        style: const TextStyle(
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
