import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/widget.dart';
import 'sign_up_three_controller.dart';

class SignUpThreePage extends StatefulWidget {
  final String title;
  const SignUpThreePage({Key key, this.title = "SignUpThree"})
      : super(key: key);

  @override
  _SignUpThreePageState createState() => _SignUpThreePageState();
}

class _SignUpThreePageState
    extends ModularState<SignUpThreePage, SignUpThreeController> {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<NavigatorState> _navigator = GlobalKey();

  bool _passwordVisible = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showErrorMessage(),
      // _showProgress(),
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
          title: Text('Criar conta'),
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
                    height: 78.0,
                    child: Text(
                      'Informe um email e de defina uma senha segura. A senha precisa ter no mínmo 6 caracteres, com letra, números e caracteres espcial.',
                      style: TextStyle(fontSize: 16.0, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 22.0),
                  Observer(builder: (_) {
                    return _buildInputField(
                        labelText: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: controller.setEmail,
                        onError: controller.warningEmail);
                  }),
                  SizedBox(height: 22.0),
                  Observer(
                    builder: (_) {
                      return _buildPasswordField();
                    },
                  ),
                  SizedBox(height: 62.0),
                  SizedBox(height: 40.0, child: _buildNextButton()),
                ],
              ),
            )),
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

  void _passwordFieldToggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
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
      onPressed: () => controller.registerUserPress(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      child: Text(
        "Cadastrar",
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

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (StoreState state) {
      switch (state) {
        case StoreState.initial:
          break;
        case StoreState.loading:
          _onLoading();
          break;
        case StoreState.loaded:
          Navigator.of(_navigator.currentContext, rootNavigator: true).pop();

          break;
      }
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 80,
            width: 100,
            child: Row(
              children: [
                SizedBox(width: 18),
                CircularProgressIndicator(),
                SizedBox(width: 18),
                Text("Processando"),
              ],
            ),
          ),
        );
      },
    );
  }
}
