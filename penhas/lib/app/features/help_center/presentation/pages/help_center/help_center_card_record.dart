import 'package:flutter/material.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/features/help_center/presentation/pages/tutorial/record/record_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class HelpCenterCardRecord extends StatelessWidget {
  final VoidCallback onPressed;

  const HelpCenterCardRecord({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: DesignSystemColors.cobaltTwo,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(0.0, 2.0),
                blurRadius: 4.0,)
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
                    'Gravações',
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
                        TutorialScaleRoute(page: const RecordTutorialPage()),
                      );
                    },
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6, bottom: 12),
                child: Text(
                    'Captura de áudio para coleta de provas contra atos violentos.',
                    style: kTextStyleRegisterSubtitleLabelStyle,),
              ),
              SizedBox(
                height: 40,
                child: FloatingActionButton(
                    heroTag: 'recordCard_1',
                    backgroundColor: DesignSystemColors.easterPurple,
                    onPressed: onPressed,
                    shape: kButtonShapeOutlinePurple,
                    child: const Text('Minhas gravações',
                        style: kTextStyleHelpCenterButtonLabel,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
