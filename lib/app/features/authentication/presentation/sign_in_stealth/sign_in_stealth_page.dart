import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../shared/design_system/logo.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../zodiac/presentation/pages/zodiac_action_button.dart';
import '../shared/login_button.dart';
import '../shared/page_progress_indicator.dart';
import '../shared/password_text_input.dart';
import '../shared/snack_bar_handler.dart';
import 'sign_in_stealth_controller.dart';

class SignInStealthPage extends StatefulWidget {
  const SignInStealthPage({Key? key, this.title = 'Authentication'})
      : super(key: key);

  final String title;

  @override
  _SignInStealthPage createState() => _SignInStealthPage();
}

class _SignInStealthPage
    extends ModularState<SignInStealthPage, SignInStealthController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String? message) {
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: SizedBox.expand(
        child: DecoratedBox(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0,
                      80.0,
                      16.0,
                      8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Icon(
                          DesignSystemLogo.penhasLogo,
                          color: Colors.white,
                          size: 60,
                        ),
                        Observer(builder: (_) => _buildUserField()),
                        Observer(
                          builder: (_) => Padding(
                            padding: const EdgeInsets.only(bottom: 44),
                            child: ZodiacActionButton(
                              sign: controller.sign,
                              isRunning: controller.isSecurityRunning,
                              listOfSign: controller.signList,
                              onPressed: () => controller.stealthAction(),
                            ),
                          ),
                        ),
                        Observer(builder: (_) => _buildPasswordField()),
                        _buildLoginButton(),
                        _buildResetPasswordButton(),
                        _changeAccount(),
                      ],
                    ),
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
    for (final d in _disposers!) {
      d();
    }
    controller.dispose();
    super.dispose();
  }

  Widget _buildUserField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 52.0),
          child: Text(
            controller.userGreetings,
            style: kTextStyleRegisterHeaderLabelStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 30),
          child: Text(
            controller.userEmail!,
            style: kTextStyleRegisterSubtitleLabelStyle,
          ),
        )
      ],
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

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: LoginButton(
        onChanged: controller.signInWithEmailAndPasswordPressed,
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: 44.0,
        child: RaisedButton(
          onPressed: () => controller.resetPasswordPressed(),
          elevation: 0,
          color: Colors.transparent,
          child: const Text(
            'Esqueci minha senha',
            style: kTextStyleFeedTweetShowReply,
          ),
        ),
      ),
    );
  }

  Widget _changeAccount() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: 44.0,
        child: RaisedButton(
          onPressed: () => controller.changeAccount(),
          elevation: 0,
          color: Colors.transparent,
          child: const Text(
            'Acessar outra conta',
            style: kTextStyleFeedTweetShowReply,
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }
}
