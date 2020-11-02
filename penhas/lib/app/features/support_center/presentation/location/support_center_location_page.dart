import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_location_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_cep_error.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_location_address.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_location_general_error.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'support_center_location_controller.dart';

class SupportCenterLocationPage extends StatefulWidget {
  SupportCenterLocationPage({Key key}) : super(key: key);

  @override
  _SupportCenterLocationPageState createState() =>
      _SupportCenterLocationPageState();
}

class _SupportCenterLocationPageState extends ModularState<
    SupportCenterLocationPage, SupportCenterLocationController> {
  final TextEditingController _textController = TextEditingController();
  final _maskCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignSystemColors.systemBackgroundColor,
      appBar: AppBar(
        title: Text("Localização"),
        elevation: 0.0,
        backgroundColor: DesignSystemColors.easterPurple,
      ),
      body: Observer(builder: (_) {
        return PageProgressIndicator(
          progressState: controller.progressState,
          progressMessage: "Pesquisando o CEP",
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildEnableGeo(),
                buildUpdateCepLocation(context),
                actionOnStateUpdate(controller.state),
              ],
            ),
          ),
        );
      }),
    );
  }
}

extension _WidgetPrivateBuilder on _SupportCenterLocationPageState {
  Widget buildUpdateCepLocation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DesignSystemColors.white,
        border:
            Border(bottom: BorderSide(color: DesignSystemColors.pinkishGrey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 20.0),
            child: Text("Escolha o ponto de partida", style: inputCepTextStyle),
          ),
          buildInputCep(context),
          buildForgetCep(),
        ],
      ),
    );
  }

  Widget buildInputCep(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 9.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Pesquise aqui",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.easterPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DesignSystemColors.easterPurple),
          ),
        ),
        textCapitalization: TextCapitalization.none,
        inputFormatters: [_maskCep],
        controller: _textController,
        keyboardType: TextInputType.number,
        onSubmitted: (t) => submitKeywordFilter(context),
        onChanged: controller.setCep,
      ),
    );
  }

  Widget buildEnableGeo() {
    final locationAsset = 'assets/images/svg/support_center/trace_route.svg';
    final locationIcon = SvgPicture.asset(
      locationAsset,
      color: DesignSystemColors.warnGrey,
    );

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: DesignSystemColors.white,
        border:
            Border(bottom: BorderSide(color: DesignSystemColors.pinkishGrey)),
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              locationIcon,
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  "Utilizando sua localização atual",
                  style: localizationDescriptionTextStyle,
                ),
              )
            ],
          ),
        ),
        onPressed: controller.askForLocationPermission,
      ),
    );
  }

  Widget buildForgetCep() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        width: 100,
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0, bottom: 0.0),
          child: RaisedButton(
            onPressed: () async {
              final url =
                  'http://www.buscacep.correios.com.br/sistemas/buscacep/buscaCepEndereco.cfm';
              launch(url);
            },
            elevation: 0,
            padding: EdgeInsets.only(left: 0.0, bottom: 0.0),
            color: Colors.transparent,
            child: Text("Não sei o CEP", style: forgetCepTextStyle),
          ),
        ),
      ),
    );
  }

  Widget actionOnStateUpdate(SupportCenterLocationState state) {
    return state.when(
      initial: () => Container(),
      addressNotFound: (msg) => Expanded(
        child: SupportCenterCepError(message: msg),
      ),
      error: (msg) => Expanded(
        child: SupportCenterLocationGeneralError(message: msg),
      ),
      loaded: (msg) => Expanded(
        child: SupportCenterLocationAddress(
          message: msg,
          onPressed: controller.seletedAddress,
        ),
      ),
    );
  }
}

extension _PrivateMethdos on _SupportCenterLocationPageState {
  void submitKeywordFilter(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

extension __SupportCenterLocationPageStateTextStyle
    on _SupportCenterLocationPageState {
  TextStyle get localizationDescriptionTextStyle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.45,
      fontWeight: FontWeight.normal);
  TextStyle get inputCepTextStyle => TextStyle(
      color: DesignSystemColors.darkIndigoThree,
      fontFamily: 'Lato',
      fontSize: 14.0,
      letterSpacing: 0.45,
      fontWeight: FontWeight.bold);
  TextStyle get forgetCepTextStyle => TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.normal,
      fontSize: 14.0,
      color: DesignSystemColors.darkIndigoThree,
      decoration: TextDecoration.underline);
}
