import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/widgets/password_text_input.dart';
import 'package:penhas/app/features/authentication/presentation/widgets/single_text_input.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'sign_in_controller.dart';

import 'sign_in_page.i18n.dart';

class SignInPage extends StatefulWidget {
  final String title;
  const SignInPage({Key key, this.title = "Authentication"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorAuthenticationMessage, (String message) {
        if (message.isNotEmpty) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
          controller.resetErrorMessage();
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Container(
          decoration: kLinearGradientDesignSystem,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 80.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(DesignSystemLogo.penhasLogo,
                      color: Colors.white, size: 60),
                  SizedBox(height: 72.0),
                  Observer(builder: (_) => _buildUserField()),
                  SizedBox(height: 24.0),
                  Observer(builder: (_) => _buildPasswordField()),
                  SizedBox(height: 24.0),
                  SizedBox(height: 40.0, child: _buildLoginButton()),
                  SizedBox(height: 24.0),
                  SizedBox(height: 40.0, child: _buildRegisterButton()),
                  SizedBox(height: 24.0),
                  SizedBox(height: 40.0, child: _buildResetPasswordButton()),
                ],
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

  SingleTextInput _buildUserField() {
    return SingleTextInput(
      keyboardType: TextInputType.emailAddress,
      labelText: 'E-mail',
      hintText: 'Digite seu e-mail',
      errorText: controller.warningEmail,
      onChanged: controller.setEmail,
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

  RaisedButton _buildLoginButton() {
    return RaisedButton(
      onPressed: () => controller.signInWithEmailAndPasswordPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        'Entrar',
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  RaisedButton _buildRegisterButton() {
    return RaisedButton(
      onPressed: () => controller.registerUserPressed(),
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        'Cadastrar',
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          letterSpacing: 0.9,
          color: Colors.white,
        ),
      ),
      shape: kButtonShapeOutlineWhite,
    );
  }

  RaisedButton _buildResetPasswordButton() {
    return RaisedButton(
      onPressed: () => controller.resetPasswordPressed(),
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        "Esqueci minha senha",
        style: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
