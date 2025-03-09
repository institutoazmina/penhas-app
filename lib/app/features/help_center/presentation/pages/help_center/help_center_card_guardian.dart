import 'package:flutter/material.dart';

import '../../../../../core/pages/tutorial_scale_route.dart';
import '../../../../../shared/design_system/button_shape.dart';
import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../tutorial/guardian/guardian_tutorial_page.dart';

class HelpCenterCardGuardian extends StatelessWidget {
  const HelpCenterCardGuardian({
    Key? key,
    required this.create,
    required this.manager,
  }) : super(key: key);

  final VoidCallback create;
  final VoidCallback manager;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: DesignSystemColors.cobaltTwo,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              offset: const Offset(0.0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 6, 13, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    'Guardiões',
                    style: kTextStyleHelpCenterActionHeader,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.help_outline,
                      color: DesignSystemColors.pumpkinOrange,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        TutorialScaleRoute(page: const GuardianTutorialPage()),
                      );
                    },
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6, bottom: 12),
                child: Text(
                  'Seus contatos de confiança para dispara pedidos de socorro.',
                  style: kTextStyleRegisterSubtitleLabelStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: FloatingActionButton(
                        heroTag: 'guardian_1',
                        backgroundColor: DesignSystemColors.cobaltTwo,
                        onPressed: create,
                        shape: kButtonShapeOutlineWhite,
                        child: const Text(
                          'Novo guardião',
                          style: kTextStyleHelpCenterButtonLabel,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: FloatingActionButton(
                        heroTag: 'guardian_2',
                        backgroundColor: DesignSystemColors.easterPurple,
                        onPressed: manager,
                        shape: kButtonShapeOutlinePurple,
                        child: const Text(
                          'Meus guardiões',
                          style: kTextStyleHelpCenterButtonLabel,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
