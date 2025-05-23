import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  const ResetPasswordThreePage(
      {super.key, this.title = 'ResetPasswordThree', required this.controller});

  final String title;
  final ResetPasswordThreeController controller;

  @override
  State<ResetPasswordThreePage> createState() => _ResetPasswordThreePageState();
}

class _ResetPasswordThreePageState extends State<ResetPasswordThreePage>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;
  ResetPasswordThreeController get _controller => widget.controller;

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
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
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
    return PasswordInputField(
      labelText: 'Senha',
      hintText: 'Digite sua nova senha',
      errorText: _controller.warningPassword,
      onChanged: _controller.setPassword,
    );
  }

  PasswordInputField _buildConfirmationPasswordField() {
    return PasswordInputField(
      labelText: 'Confirmação de senha',
      hintText: 'Digite sua senha novamente',
      errorText: _controller.warningConfirmationPassword,
      onChanged: _controller.setConfirmationPassword,
    );
  }

  Widget _buildNextButton() {
    return PenhasButton.roundedFilled(
      onPressed: _controller.nextStepPressed,
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
    return reaction((_) => _controller.errorMessage, (String? message) {
      showSnackBar(scaffoldKey: _scaffoldKey, message: message);
    });
  }

  ReactionDisposer _showProgress() {
    return reaction((_) => _controller.currentState,
        (PageProgressState status) {
      setState(() {
        _currentState = status;
      });
    });
  }
}
