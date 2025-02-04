import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
  const SignInPage({Key? key, this.title = 'Authentication'}) : super(key: key);

  final String title;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController>
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
                        onPressed: controller.resetPasswordPressed,
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
        onChanged: controller.setEmail,
        boxDecoration: WhiteBoxDecorationStyle(
          labelText: 'E-mail',
          hintText: 'Digite seu e-mail',
          errorText: controller.warningEmail,
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
        errorText: controller.warningPassword,
        onChanged: controller.setPassword,
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: LoginButton(
        onChanged: () async => controller.signInWithEmailAndPasswordPressed(),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: PenhasButton.roundedOutlined(
        onPressed: () => controller.registerUserPressed(),
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
