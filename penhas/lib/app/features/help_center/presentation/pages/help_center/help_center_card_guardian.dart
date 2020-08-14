import 'package:flutter/material.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/guardian/guardian_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class HelpCenterCardGuardian extends StatelessWidget {
  final VoidCallback create;
  final VoidCallback manager;

  const HelpCenterCardGuardian({
    Key key,
    @required this.create,
    @required this.manager,
  }) : super(key: key);

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
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(0.0, 2.0),
                blurRadius: 4.0)
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(13, 6, 13, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Guardiões',
                    style: kTextStyleHelpCenterActionHeader,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.help_outline,
                      color: DesignSystemColors.pumpkinOrange,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        TutorialScaleRoute(page: GuardianTutorialPage()),
                      );
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 6, bottom: 12),
                child: Text(
                    'Seus contatos de confiança para dispara pedidos de socorro.',
                    style: kTextStyleRegisterSubtitleLabelStyle),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: FloatingActionButton(
                        heroTag: 'guardian_1',
                        backgroundColor: DesignSystemColors.cobaltTwo,
                        child: Text('Novo guardião',
                            style: kTextStyleHelpCenterButtonLabel),
                        onPressed: create,
                        shape: kButtonShapeOutlineWhite,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 40,
                      child: FloatingActionButton(
                          heroTag: 'guardian_2',
                          backgroundColor: DesignSystemColors.easterPurple,
                          child: Text(
                            'Meus guardiões',
                            style: kTextStyleHelpCenterButtonLabel,
                          ),
                          onPressed: manager,
                          shape: kButtonShapeOutlinePurple),
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
