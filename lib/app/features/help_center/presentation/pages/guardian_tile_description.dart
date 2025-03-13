import 'package:flutter/material.dart';

import '../../../../shared/design_system/colors.dart';

class GuardianTileDescription extends StatelessWidget {
  const GuardianTileDescription({
    super.key,
    required this.description,
  });

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description!,
      style: const TextStyle(
        color: DesignSystemColors.darkIndigoThree,
        fontSize: 14.0,
        letterSpacing: 0.45,
        fontFamily: 'Lato',
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
