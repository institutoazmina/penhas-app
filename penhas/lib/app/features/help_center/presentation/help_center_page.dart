import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/help_center_state.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_guardian.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_police.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_record.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_card_guardian.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_card_record.dart';
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
    extends ModularState<HelpCenterPage, HelpCenterController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _loadState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showAlert(),
      _showErrorMessage(),
      _showLoadProgress(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: DesignSystemColors.helpCenterBackGround,
      body: PageProgressIndicator(
        progressState: _loadState,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _actionBuilder(),
                  _warnningBuilder(),
                  _warrningLocation(),
                  _guardianCardBuilder(),
                  _recordCardBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _recordCardBuilder() {
    return HelpCenterCardRecord();
  }

  Widget _guardianCardBuilder() {
    return HelpCenterCardGuardian(
      create: () => controller.newGuardian(),
      manager: () => controller.guardians(),
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

  Widget _warrningLocation() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: DesignSystemColors.nigthBlue,
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.location_off,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  'Você tem guardiã ativos mas não autoriza o acesso a sua localização. Desta maneira as guardiãs não receberão a sua localização quando acionadas. Deseja habilitar a localização?',
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
          HelpCenterActionPolice(),
          HelpCenterActionGuardian(
            onPressed: () => controller.triggerGuardian(),
          ),
          HelpCenterActionRecord(),
        ],
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showAlert() {
    return reaction((_) => controller.alertState, (HelpCenterState status) {
      status.when(
        initial: () {},
        guardianTriggered: (action) => _showGuardianTrigger(action),
      );
    });
  }

  ReactionDisposer _showLoadProgress() {
    return reaction((_) => controller.loadState, (PageProgressState status) {
      setState(() {
        _loadState = status;
      });
    });
  }

  void _showGuardianTrigger(GuardianAlertMessageAction action) {
    Modular.to.showDialog(
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              SvgPicture.asset(
                  'assets/images/svg/help_center/guardians/guardians_alert.svg'),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child:
                    Text('Alerta enviado!', style: kTextStyleAlertDialogTitle),
              ),
            ],
          ),
          content: Text(
            action.message,
            style: kTextStyleAlertDialogDescription,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () async {
                Modular.to.pop();
                action.onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
