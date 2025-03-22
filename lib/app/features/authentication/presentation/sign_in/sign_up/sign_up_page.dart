import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../../shared/design_system/text_styles.dart';
import '../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../../shared/navigation/app_navigator.dart';
import '../../shared/input_box_style.dart';
import '../../shared/page_progress_indicator.dart';
import '../../shared/single_text_input.dart';
import '../../shared/snack_bar_handler.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage(
      {super.key, this.title = 'SignUp', required this.controller});

  final String title;
  final SignUpController controller;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  SignUpController get _controller => widget.controller;

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
    for (final d in _disposers!) {
      d();
    }
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
            foregroundColor: DesignSystemColors.white,
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
      key: const Key('sign_up_cep'),
      inputFormatter: _maskCep,
      onChanged: _controller.setCep,
      keyboardType: TextInputType.number,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'CEP',
        labelText: 'CEP',
        errorText: _controller.warningCep,
      ),
    );
  }

  Widget _forgetCep() {
    return Container(
      width: 100,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.zero,
        child: PenhasButton.text(
          onPressed: () async {
            const url =
                'http://www.buscacep.correios.com.br/sistemas/buscacep/buscaCepEndereco.cfm';
            AppNavigator.launchURL(url);
          },
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
      key: const Key('sign_up_cpf'),
      inputFormatter: _maskCpf,
      onChanged: _controller.setCpf,
      keyboardType: TextInputType.number,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'CPF',
        labelText: 'CPF',
        errorText: _controller.warningCpf,
      ),
    );
  }

  SingleTextInput _buildFullName() {
    return SingleTextInput(
      onChanged: _controller.setFullname,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'Nome completo',
        errorText: _controller.warningFullname,
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
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  SingleTextInput _builBirthday() {
    return SingleTextInput(
      inputFormatter: _maskDate,
      onChanged: _controller.setBirthday,
      keyboardType: TextInputType.datetime,
      boxDecoration: WhiteBoxDecorationStyle(
        hintText: 'Dia / Mês / Ano',
        labelText: 'Data de nascimento',
        errorText: _controller.warningBirthday,
      ),
    );
  }

  Widget _buildNextButton() {
    return PenhasButton.roundedFilled(
      onPressed: () => _controller.nextStepPressed(),
      child: const Text(
        'Próximo',
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => _controller.currentState,
        (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
