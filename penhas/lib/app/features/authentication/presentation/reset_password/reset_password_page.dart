import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/widget.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  final String title;
  const ResetPasswordPage({Key key, this.title = "ResetPassword"})
      : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends ModularState<ResetPasswordPage, ResetPasswordController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: SizedBox.expand(
          child: Container(
            decoration: DesignSystemWidget.background(),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      child: Text(
                        'Esqueceu a senha?',
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
                        'Informe o seu e-mail para receber o código de recuperação de senha.',
                        style: TextStyle(fontSize: 16.0, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24),
                    Observer(builder: (_) {
                      return _buildInputField(
                          labelText: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: controller.setEmail,
                          onError: controller.warningEmail);
                    }),
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

  TextFormField _buildInputField({
    String labelText,
    String hintText,
    TextInputType keyboardType,
    Function(String) onChanged,
    String onError,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
        errorText: (onError?.isEmpty ?? true) ? null : onError,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
      ),
    );
  }

  RaisedButton _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "Próximo",
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
}
