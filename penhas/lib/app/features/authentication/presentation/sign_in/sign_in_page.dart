import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'package:penhas/app/shared/design_system/widget.dart';
import 'sign_in_controller.dart';

import 'sign_in_page.i18n.dart';

class SignInPage extends StatefulWidget {
  final String title;
  const SignInPage({Key key, this.title = "Authentication"}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController> {
  //use 'controller' variable to access controller
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Container(
          decoration: DesignSystemWidget.background(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 80.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(DesignSystemLogo.penhasLogo,
                      color: Colors.white, size: 60),
                  SizedBox(height: 72.0),
                  SizedBox(height: 40.0, child: _buildUserField()),
                  SizedBox(height: 24.0),
                  SizedBox(height: 40.0, child: _buildPasswordField()),
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

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      keyboardType: TextInputType.text,
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: "Senha".i18n,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        hintText: "Digite sua senha".i18n,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        suffixIcon: IconButton(
          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70),
          onPressed: _toggle,
        ),
      ),
    );
  }

  TextField _buildUserField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: "E-mail".i18n,
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Digite seu e-mail".i18n,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        border: OutlineInputBorder(),
      ),
    );
  }

  RaisedButton _buildLoginButton() {
    return RaisedButton(
      onPressed: () {},
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "ENTRAR".i18n,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
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
      onPressed: () {},
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        "CADASTRAR".i18n,
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.white),
      ),
    );
  }

  RaisedButton _buildResetPasswordButton() {
    return RaisedButton(
      onPressed: () {},
      elevation: 0,
      color: Colors.transparent,
      child: Text(
        "Esqueci minha senha".i18n,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
