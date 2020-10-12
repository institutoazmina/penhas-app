import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/input_box_style.dart';
import 'package:penhas/app/features/authentication/presentation/shared/login_button.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/single_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  final String title;
  const SignInPage({Key key, this.title = "Authentication"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
      reaction((_) => controller.currentState, (PageProgressState status) {
        setState(() {
          _currentState = status;
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 80.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(DesignSystemLogo.penhasLogo,
                          color: Colors.white, size: 60),
                      Observer(builder: (_) => _buildUserField()),
                      Observer(builder: (_) => _buildPasswordField()),
                      _buildLoginButton(),
                      _buildRegisterButton(),
                      _buildResetPasswordButton(),
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

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  Widget _buildUserField() {
    return Padding(
      padding: EdgeInsets.only(top: 72),
      child: SingleTextInput(
        keyboardType: TextInputType.emailAddress,
        onChanged: controller.setEmail,
        boxDecoration: WhiteBoxDecorationStyle(
          labelText: 'E-mail',
          hintText: 'Digite seu e-mail',
          errorText: controller.warningEmail,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: PassordInputField(
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        errorText: controller.warningPassword,
        onChanged: controller.setPassword,
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.only(top: 24.0),
      child: LoginButton(
        onChanged: () async => controller.signInWithEmailAndPasswordPressed(),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 44,
        child: RaisedButton(
          onPressed: () => controller.registerUserPressed(),
          elevation: 0,
          color: Colors.transparent,
          child: Text(
            'Cadastrar',
            style: kTextStyleDefaultFilledButtonLabel,
          ),
          shape: kButtonShapeOutlineWhite,
        ),
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 44.0,
        child: RaisedButton(
          onPressed: () => controller.resetPasswordPressed(),
          elevation: 0,
          color: Colors.transparent,
          child: Text(
            "Esqueci minha senha",
            style: kTextStyleFeedTweetShowReply,
          ),
        ),
      ),
    );
  }

  _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0)
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
