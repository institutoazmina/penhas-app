import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/help_center/domain/states/guardian_alert_state.dart';
import 'package:penhas/app/features/help_center/domain/states/help_center_state.dart';
import 'package:penhas/app/features/help_center/presentation/help_center_controller.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_guardian.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_police.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_action_record.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_card_guardian.dart';
import 'package:penhas/app/features/help_center/presentation/pages/help_center/help_center_card_record.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key, this.title = 'HelpCenter'}) : super(key: key);

  final String title;

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState
    extends ModularState<HelpCenterPage, HelpCenterController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _loadState = PageProgressState.initial;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.checkLocalicationRequired();
    });
  }

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
                  Observer(
                    builder: (_) {
                      return controller.isLocationPermissionRequired
                          ? _warrningLocation()
                          : Container();
                    },
                  ),
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
    return HelpCenterCardRecord(
      onPressed: () => controller.audios(),
    );
  }

  Widget _guardianCardBuilder() {
    return HelpCenterCardGuardian(
      create: () => controller.newGuardian(),
      manager: () => controller.guardians(),
    );
  }

  Widget _warnningBuilder() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Container(
        color: DesignSystemColors.nigthBlue,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SvgPicture.asset(
                  'assets/images/svg/bottom_bar/emergency_controll.svg',
                ),
              ),
              const Expanded(
                flex: 6,
                child: Text(
                  'Se o agressor estiver com arma de fogo ou objetos que possam machucar, chame a pol??cia!',
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
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: DesignSystemColors.nigthBlue,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                child: Icon(
                  Icons.location_off,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  'Voc?? tem guardi?? ativos mas n??o autoriza o acesso a sua localiza????o. Desta maneira as guardi??s n??o receber??o a sua localiza????o quando acionadas. Deseja habilitar a localiza????o?',
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          HelpCenterActionPolice(
            onPressed: () => controller.triggerCallPolice(),
          ),
          HelpCenterActionGuardian(
            onPressed: () => controller.triggerGuardian(),
          ),
          HelpCenterActionRecord(
            onPressed: () => controller.triggerAudioRecord(),
          ),
        ],
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showAlert() {
    return reaction((_) => controller.alertState, (HelpCenterState status) {
      status.when(
        initial: () {},
        guardianTriggered: (action) => _showGuardianTrigger(action),
        callingPolice: (callingNumber) async => _actionOnTap(callingNumber),
      );
    });
  }

  Future<void> _actionOnTap(String callingNumber) async {
    await FlutterPhoneDirectCaller.callNumber(callingNumber);
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
                'assets/images/svg/help_center/guardians/guardians_alert.svg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(action.title, style: kTextStyleAlertDialogTitle),
              ),
            ],
          ),
          content: Text(
            action.message!,
            style: kTextStyleAlertDialogDescription,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Fechar'),
              onPressed: () async {
                Navigator.of(context).pop();
                action.onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
