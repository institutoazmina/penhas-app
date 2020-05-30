import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'reset_password_two_controller.dart';

class ResetPasswordTwoPage extends StatefulWidget {
  final String title;
  const ResetPasswordTwoPage({Key key, this.title = "ResetPasswordTwo"})
      : super(key: key);

  @override
  _ResetPasswordTwoPageState createState() => _ResetPasswordTwoPageState();
}

class _ResetPasswordTwoPageState
    extends ModularState<ResetPasswordTwoPage, ResetPasswordTwoController> {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _maskToken = MaskTextInputFormatter(
    mask: '# # # # # #',
    filter: {"#": RegExp(r'[0-9]')},
  );

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
                      height: 40,
                      child: Text(
                        'Verifique seu e-mail',
                        style: kTextStyleRegisterHeaderLabelStyle,
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
                                'assets/images/reset_password_02/reset_password_02.png'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 60,
                      child: Text(
                        'Por favor, digite o código de verificação que enviamos para o e-mail de recuperação.',
                        style: TextStyle(fontSize: 16.0, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 4),
                    Observer(builder: (_) {
                      return _buildInputField(
                        labelText: 'Token',
                        keyboardType: TextInputType.number,
                        onChanged: controller.setToken,
                        onError: controller.warrningToken,
                      );
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
      autofocus: true,
      autocorrect: false,
      inputFormatters: [_maskToken],
      textInputAction: TextInputAction.done,
      style: TextStyle(color: Colors.white, fontSize: 48),
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
