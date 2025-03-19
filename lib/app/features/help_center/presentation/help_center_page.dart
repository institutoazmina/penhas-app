import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extension/asuka.dart';
import '../../../shared/design_system/colors.dart';
import '../../../shared/design_system/text_styles.dart';
import '../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../domain/states/guardian_alert_state.dart';
import '../domain/states/help_center_state.dart';
import 'help_center_controller.dart';
import 'pages/help_center/help_center_action_guardian.dart';
import 'pages/help_center/help_center_action_police.dart';
import 'pages/help_center/help_center_action_record.dart';
import 'pages/help_center/help_center_card_guardian.dart';
import 'pages/help_center/help_center_card_record.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage(
      {super.key, this.title = 'HelpCenter', required this.controller});

  final HelpCenterController controller;

  final String title;

  @override
  HelpCenterPageState createState() => HelpCenterPageState();
}

class HelpCenterPageState extends State<HelpCenterPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _loadState = PageProgressState.initial;
  HelpCenterController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.checkLocalicationRequired();
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
                      return _controller.isLocationPermissionRequired
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
      onPressed: () => _controller.audios(),
    );
  }

  Widget _guardianCardBuilder() {
    return HelpCenterCardGuardian(
      create: () => _controller.newGuardian(),
      manager: () => _controller.guardians(),
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
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        color: DesignSystemColors.nigthBlue,
        child: const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 12.0,
            bottom: 12.0,
          ),
          child: Row(
            children: <Widget>[
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          HelpCenterActionPolice(
            onPressed: () => _controller.triggerCallPolice(),
          ),
          HelpCenterActionGuardian(
            onPressed: () => _controller.triggerGuardian(),
          ),
          HelpCenterActionRecord(
            onPressed: () => _controller.triggerAudioRecord(),
          ),
        ],
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showAlert() {
    return reaction((_) => _controller.alertState, (HelpCenterState status) {
      status.when(
        initial: () {},
        guardianTriggered: (action) => _showGuardianTrigger(action),
        callingPolice: (callingNumber) async => _actionOnTap(callingNumber),
      );
    });
  }

  Future<void> _actionOnTap(String callingNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: callingNumber,
    );
    if (await canLaunchUrl(Uri.parse(launchUri.toString()))) {
      await launchUrl(Uri.parse(launchUri.toString()));
    } else {
      throw 'Could not launch $callingNumber';
    }
  }

  ReactionDisposer _showLoadProgress() {
    return reaction((_) => _controller.loadState, (PageProgressState status) {
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
            PenhasButton.text(
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
