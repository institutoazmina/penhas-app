import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/core/pages/tutorial_scale_route.dart';
import 'package:penhas/app/features/help_center/presentation/page/tutorial/guardian/guardian_tutorial_page.dart';
import 'package:penhas/app/features/help_center/presentation/page/tutorial/record/record_tutorial_page.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'help_center_controller.dart';

class HelpCenterPage extends StatefulWidget {
  final String title;
  const HelpCenterPage({Key key, this.title = "HelpCenter"}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState
    extends ModularState<HelpCenterPage, HelpCenterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystemColors.helpCenterBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _actionBuilder(),
                _warnningBuilder(),
                _guardianCardBuilder(context),
                _recordCardBuilder(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _recordCardBuilder(BuildContext context) {
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
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
                    'Gravações',
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
                        TutorialScaleRoute(page: RecordTutorialPage()),
                      ).whenComplete(() => print('ola mundo!'));
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 6, bottom: 12),
                child: Text(
                    'Captura de áudio para coleta de provas contra atos violentos.',
                    style: kTextStyleRegisterSubtitleLabelStyle),
              ),
              SizedBox(
                height: 40,
                child: FloatingActionButton(
                    heroTag: 'recordCard_1',
                    backgroundColor: DesignSystemColors.easterPurple,
                    child: Text('Meus guardiões'),
                    onPressed: null,
                    shape: kButtonShapeOutlinePurple),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _guardianCardBuilder(BuildContext context) {
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
                      ).whenComplete(() => print('ola mundo!'));
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
                        child: Text('Novo guardião'),
                        onPressed: null,
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
                          child: Text('Meus guardiões'),
                          onPressed: null,
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

  Widget _warnningBuilder() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        color: DesignSystemColors.nigthBlue,
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: SvgPicture.asset(
                      'assets/images/svg/bottom_bar/emergency_controll.svg')),
              Expanded(
                flex: 6,
                child: Text(
                  'Se o agressor estiver com arma de fogo ou objetos que possam machucar, chame a polícia!',
                  style: kTextStyleRegisterSubtitleLabelStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionBuilder() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(width: 2, color: DesignSystemColors.pumpkinOrange),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 41,
                    width: 49,
                    child: SvgPicture.asset(
                        'assets/images/svg/help_center/help_center_call_police.svg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Text(
                    'Ligar para a policia',
                    style: kTextStyleHelpCenterActionCallPolice,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border:
                  Border.all(width: 2, color: DesignSystemColors.easterPurple),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 41,
                    width: 49,
                    child: SvgPicture.asset(
                        'assets/images/svg/help_center/help_center_guardian.svg'),
                  ),
                ),
                Padding(
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
          Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 2, color: DesignSystemColors.pinky),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 41,
                    width: 49,
                    child: SvgPicture.asset(
                        'assets/images/svg/help_center/help_center_record.svg'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                  child: Text(
                    'Gravar áudio',
                    style: kTextStyleHelpCenterActionRecord,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _panicButtomHelpBuilder() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 16.0, right: 16.0),
        child: Text(
          'Botão de pânico',
          style: kTextStyleHelpCenterPanicButonHelp,
        ),
      ),
    );
  }
}
