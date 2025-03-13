import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../shared/design_system/logo.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../zodiac/presentation/pages/zodiac_action_button.dart';
import '../shared/login_button.dart';
import '../shared/page_progress_indicator.dart';
import '../shared/password_text_input.dart';
import '../shared/snack_bar_handler.dart';
import 'sign_in_stealth_controller.dart';

class SignInStealthPage extends StatefulWidget {
  const SignInStealthPage(
      {super.key, this.title = 'Authentication', required this.controller});

  final String title;
  final SignInStealthController controller;

  @override
  SignInStealthPageState createState() => SignInStealthPageState();
}

class SignInStealthPageState extends State<SignInStealthPage>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  SignInStealthController get _controller => widget.controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => _controller.errorMessage, (String? message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
      reaction((_) => _controller.currentState, (PageProgressState status) {
        setState(() {
          _currentState = status;
        });
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        SystemNavigator.pop();
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
                              sign: _controller.sign,
                              isRunning: _controller.isSecurityRunning,
                              listOfSign: _controller.signList,
                              onPressed: () => _controller.stealthAction(),
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
    _controller.dispose();
    super.dispose();
  }

  Widget _buildUserField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 52.0),
          child: Text(
            _controller.userGreetings,
            style: kTextStyleRegisterHeaderLabelStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 30),
          child: Text(
            _controller.userEmail!,
            style: kTextStyleRegisterSubtitleLabelStyle,
          ),
        )
      ],
    );
  }

  PasswordInputField _buildPasswordField() {
    return PasswordInputField(
      labelText: 'Senha',
      hintText: 'Digite sua senha',
      errorText: _controller.warningPassword,
      onChanged: _controller.setPassword,
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: LoginButton(
        onChanged: _controller.signInWithEmailAndPasswordPressed,
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: 44.0,
        child: PenhasButton.text(
          onPressed: () => _controller.resetPasswordPressed(),
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
        child: PenhasButton.text(
          onPressed: () => _controller.changeAccount(),
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
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
