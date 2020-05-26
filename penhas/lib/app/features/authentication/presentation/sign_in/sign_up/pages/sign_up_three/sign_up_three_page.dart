import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'sign_up_three_controller.dart';

class SignUpThreePage extends StatefulWidget {
  final String title;
  const SignUpThreePage({Key key, this.title = "SignUpThree"})
      : super(key: key);

  @override
  _SignUpThreePageState createState() => _SignUpThreePageState();
}

class _SignUpThreePageState
    extends ModularState<SignUpThreePage, SignUpThreeController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      _showProgress(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((d) => d());
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
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: 18.0),
                    _buildSubHeader(),
                    SizedBox(height: 22.0),
                    Observer(builder: (_) => _buildEmailField()),
                    SizedBox(height: 22.0),
                    Observer(builder: (_) => _buildPasswordField()),
                    SizedBox(height: 62.0),
                    SizedBox(height: 40.0, child: _buildNextButton()),
                  ],
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }

  SingleTextInput _buildEmailField() {
    return SingleTextInput(
        labelText: 'E-mail',
        keyboardType: TextInputType.emailAddress,
        onChanged: controller.setEmail,
        errorText: controller.warningEmail);
  }

  SizedBox _buildSubHeader() {
    return SizedBox(
      height: 60.0,
      child: Text(
        'Informe um email e de defina uma senha segura. A senha precisa ter no mínmo 6 caracteres, com letra, números e caracteres espcial.',
        style: kRegisterSubHeaderLabelStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Text _buildHeader() {
    return Text(
      'Crie sua conta',
      style: kRegisterHeaderLabelStyle,
      textAlign: TextAlign.center,
    );
  }

  PassordInputField _buildPasswordField() {
    return PassordInputField(
      labelText: 'Senha',
      hintText: 'Digite sua senha',
      errorText: controller.warningPassword,
      onChanged: controller.setPassword,
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.registerUserPress(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "Cadastrar",
        style: kDefaultFilledButtonLabel,
      ),
      shape: kButtonShapeFilled,
    );
  }

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
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
