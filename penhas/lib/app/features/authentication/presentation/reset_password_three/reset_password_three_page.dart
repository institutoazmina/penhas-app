import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'reset_password_three_controller.dart';

class ResetPasswordThreePage extends StatefulWidget {
  final String title;
  const ResetPasswordThreePage({Key key, this.title = "ResetPasswordThree"})
      : super(key: key);

  @override
  _ResetPasswordThreePageState createState() => _ResetPasswordThreePageState();
}

class _ResetPasswordThreePageState
    extends ModularState<ResetPasswordThreePage, ResetPasswordThreeController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _passwordVisible = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _disposers.forEach((d) => d());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (currentFocus != null && !currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: SizedBox.expand(
          child: Container(
            decoration: kLinearGradientDesignSystem,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                      child: Text(
                        'Configure uma nova senha',
                        style: TextStyle(
                            fontSize: 28.0, color: DesignSystemColors.pigPing),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                          width: 107,
                          child: Image(
                            image: AssetImage(
                                'assets/images/reset_password_01/reset_password_01.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 40,
                      child: Text(
                        'Crie uma senha diferente da anteriors',
                        style: TextStyle(fontSize: 16.0, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24),
                    Observer(
                      builder: (_) {
                        return _buildPasswordField();
                      },
                    ),
                    SizedBox(height: 24),
                    Observer(
                      builder: (_) {
                        return _buildNextButton();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      keyboardType: TextInputType.text,
      autocorrect: false,
      onChanged: controller.setPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        errorText: controller.warningPassword.isEmpty
            ? null
            : controller.warningPassword,
        labelText: "Senha",
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
        suffixIcon: IconButton(
          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70),
          onPressed: _passwordFieldToggle,
        ),
      ),
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "Salvar",
        style: TextStyle(color: Colors.white, fontSize: 14.0),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String message) {
      if (message.isNotEmpty) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    });
  }

  void _passwordFieldToggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
