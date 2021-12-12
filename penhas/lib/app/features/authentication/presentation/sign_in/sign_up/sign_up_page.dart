import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/authentication/presentation/sign_in/sign_up/sign_up_controller.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title = 'SignUp'}) : super(key: key);

  final String title;
  const SignUpPage({Key? key, this.title = "SignUp"}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  final format = DateFormat('dd/MM/yyyy');

  final _maskCpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp('[0-9]')},
  );

  final _maskCep = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp('[0-9]')},
  );

  final _maskDate = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp('[0-9]')},
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showProgress(),
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    _disposers!.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _buildHeader(),
                      const SizedBox(height: 18.0),
                      _buildSubHeader(),
                      const SizedBox(height: 22.0),
                      Observer(builder: (_) => _buildFullName()),
                      const SizedBox(height: 24.0),
                      Observer(builder: (_) => _builBirthday()),
                      const SizedBox(height: 24.0),
                      Observer(
                        builder: (_) {
                          return _buildCpf();
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Observer(
                        builder: (_) {
                          return _buildCep();
                        },
                      ),
                      _forgetCep(),
                      const SizedBox(height: 24.0),
                      SizedBox(height: 40.0, child: _buildNextButton()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleTextInput _buildCep() {
    return SingleTextInput(
      inputFormatter: _maskCep,
      onChanged: controller.setCep,
      keyboardType: TextInputType.number,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'CEP',
        labelText: 'CEP',
        errorText: controller.warningCep,
      ),
    );
  }

  Widget _forgetCep() {
    return Container(
      width: 100,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.zero,
        child: RaisedButton(
          onPressed: () async {
            const url =
                'http://www.buscacep.correios.com.br/sistemas/buscacep/buscaCepEndereco.cfm';
            launch(url);
          },
          elevation: 0,
          padding: EdgeInsets.zero,
          color: Colors.transparent,
          child: const Text(
            'Não sei o meu CEP',
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  SingleTextInput _buildCpf() {
    return SingleTextInput(
      inputFormatter: _maskCpf,
      onChanged: controller.setCpf,
      keyboardType: TextInputType.number,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'CPF',
        labelText: 'CPF',
        errorText: controller.warningCpf,
      ),
    );
  }

  SingleTextInput _buildFullName() {
    return SingleTextInput(
      onChanged: controller.setFullname,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'Nome completo',
        errorText: controller.warningFullname,
      ),
    );
  }

  SizedBox _buildSubHeader() {
    return const SizedBox(
      height: 60.0,
      child: Text(
        'Para sua segurança pedimos aos nossos usuários o CPF.',
        style: kTextStyleRegisterSubHeaderLabelStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _buildHeader() {
    return const Text(
      'Crie sua conta',
      style: kTextStyleRegisterHeaderLabelStyle,
      textAlign: TextAlign.center,
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  SingleTextInput _builBirthday() {
    return SingleTextInput(
      inputFormatter: _maskDate,
      onChanged: controller.setBirthday,
      keyboardType: TextInputType.datetime,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'Dia / Mês / Ano',
        labelText: 'Data de nascimento',
        errorText: controller.warningBirthday,
      ),
    );
  }

  Widget _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      shape: kButtonShapeFilled,
      child: const Text(
        'Próximo',
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
