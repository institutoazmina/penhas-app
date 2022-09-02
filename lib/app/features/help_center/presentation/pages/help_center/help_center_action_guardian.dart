import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class HelpCenterActionGuardian extends StatelessWidget {
  const HelpCenterActionGuardian({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2, color: DesignSystemColors.easterPurple),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 41,
                width: 49,
                child: SvgPicture.asset(
                    'assets/images/svg/help_center/help_center_guardian.svg',),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
              child: Text(
                'Alertar guardiões',
                style: kTextStyleHelpCenterActionGuardian,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
