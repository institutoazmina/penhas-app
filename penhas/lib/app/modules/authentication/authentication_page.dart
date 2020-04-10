import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/shared/design_system/logo.dart';
import 'authentication_controller.dart';

class AuthenticationPage extends StatefulWidget {
  final String title;
  const AuthenticationPage({Key key, this.title = "Authentication"})
      : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState
    extends ModularState<AuthenticationPage, AuthenticationController> {
  //use 'controller' variable to access controller

  final instance = Uri.parse("https://mastodon.appcivico.com");
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/background_blur/background_blur.png'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 80.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(DesignSystemLogo.penhasLogo,
                    color: Colors.white, size: 60),
                SizedBox(height: 80.0),
                _buildUserField(),
                SizedBox(height: 32.0),
                _buildPasswordField(),
                SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 138.0,
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        child: Text("ENTRAR"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 86.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.transparent,
                      textColor: Colors.white,
                      child: Text("Esqueci minha senha"),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.transparent,
                      textColor: Colors.white,
                      child: Text("Cadastrar"),
                    ),
                  ],
                )
              ],
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
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: "Senha",
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        hintText: "Digite sua senha",
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
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        labelText: "Email",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Digite seu email",
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        border: OutlineInputBorder(),
      ),
    );
  }
}
