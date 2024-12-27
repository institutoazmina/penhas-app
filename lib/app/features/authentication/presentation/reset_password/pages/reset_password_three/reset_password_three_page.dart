import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../../../shared/design_system/text_styles.dart';
import '../../../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../../../shared/page_progress_indicator.dart';
import '../../../shared/password_text_input.dart';
import '../../../shared/snack_bar_handler.dart';
import 'reset_password_three_controller.dart';

class ResetPasswordThreePage extends StatefulWidget {
  const ResetPasswordThreePage({Key? key, this.title = 'ResetPasswordThree'})
      : super(key: key);

  final String title;

  @override
  _ResetPasswordThreePageState createState() => _ResetPasswordThreePageState();
}

class _ResetPasswordThreePageState
    extends ModularState<ResetPasswordThreePage, ResetPasswordThreeController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      _showProgress(),
      _showErrorMessage(),
    ];
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: kLinearGradientDesignSystem,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          body: PageProgressIndicator(
            progressState: _currentState,
            child: GestureDetector(
              onTap: () => _handleTap(context),
              onPanDown: (_) => _handleTap(context),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(30.0, 16.0, 30.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 60,
                        child: Text(
                          'Configure uma nova senha',
                          style: kTextStyleRegisterHeaderLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 102,
                            width: 102,
                            child: SvgPicture.asset(
                              'assets/images/svg/reset_password/recovery_password_step_2.svg',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(
                        height: 40,
                        child: Text(
                          'Crie uma senha diferente das anteriores',
                          style: kTextStyleRegisterSubtitleLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Observer(
                        builder: (_) {
                          return _buildPasswordField();
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Observer(
                        builder: (_) => _buildConfirmationPasswordField(),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(height: 40.0, child: _buildNextButton()),
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

  Widget _buildPasswordField() {
    return PassordInputField(
      labelText: 'Senha',
      hintText: 'Digite sua nova senha',
      errorText: controller.warningPassword,
      onChanged: controller.setPassword,
    );
  }

  PassordInputField _buildConfirmationPasswordField() {
    return PassordInputField(
      labelText: 'Confirmação de senha',
      hintText: 'Digite sua senha novamente',
      errorText: controller.warningConfirmationPassword,
      onChanged: controller.setConfirmationPassword,
    );
  }

  Widget _buildNextButton() {
    return PenhasButton.roundedFilled(
      onPressed: controller.nextStepPressed,
      child: const Text(
        'Salvar',
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  ReactionDisposer _showErrorMessage() {
    return reaction((_) => controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => controller.currentState, (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
