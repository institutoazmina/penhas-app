import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../shared/design_system/link_button.dart';
import '../../../../shared/design_system/logo.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../../shared/navigation/app_navigator.dart';
import '../../../../shared/navigation/app_route.dart';
import '../shared/input_box_style.dart';
import '../shared/login_button.dart';
import '../shared/page_progress_indicator.dart';
import '../shared/password_text_input.dart';
import '../shared/single_text_input.dart';
import '../shared/snack_bar_handler.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage(
      {super.key, this.title = 'Authentication', required this.controller});

  final String title;
  final SignInController controller;

  @override
  SignInPageState createState() => SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  SignInController get _controller => widget.controller;

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
                      Observer(builder: (_) => _buildPasswordField()),
                      _buildLoginButton(),
                      _buildRegisterButton(),
                      const SizedBox(height: 16.0),
                      LinkButton(
                        onPressed: _controller.resetPasswordPressed,
                        text: 'Esqueci minha senha',
                      ),
                      LinkButton(
                        onPressed: () => AppNavigator.push(
                          AppRoute('/authentication/terms_of_use'),
                        ),
                        text: 'Termos de uso',
                      ),
                      LinkButton(
                        onPressed: () => AppNavigator.push(
                          AppRoute('/authentication/privacy_policy'),
                        ),
                        text: 'Política de privacidade',
                      ),
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
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  Widget _buildUserField() {
    return Padding(
      padding: const EdgeInsets.only(top: 72),
      child: SingleTextInput(
        keyboardType: TextInputType.emailAddress,
        onChanged: _controller.setEmail,
        boxDecoration: WhiteBoxDecorationStyle(
          labelText: 'E-mail',
          hintText: 'Digite seu e-mail',
          errorText: _controller.warningEmail,
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: PasswordInputField(
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        errorText: _controller.warningPassword,
        onChanged: _controller.setPassword,
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: LoginButton(
        onChanged: () async => _controller.signInWithEmailAndPasswordPressed(),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: PenhasButton.roundedOutlined(
        onPressed: () => _controller.registerUserPressed(),
        child: const Text(
          'Cadastrar',
          style: kTextStyleDefaultFilledButtonLabel,
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
