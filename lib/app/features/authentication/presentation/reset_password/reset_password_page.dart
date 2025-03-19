import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

import '../../../../shared/design_system/colors.dart';
import '../../../../shared/design_system/linear_gradient_design_system.dart';
import '../../../../shared/design_system/text_styles.dart';
import '../../../../shared/design_system/widgets/buttons/penhas_button.dart';
import '../shared/input_box_style.dart';
import '../shared/page_progress_indicator.dart';
import '../shared/single_text_input.dart';
import '../shared/snack_bar_handler.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    required this.controller,
    super.key,
  });

  final ResetPasswordController controller;

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage>
    with SnackBarHandler {
  ResetPasswordController get controller => widget.controller;
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
            foregroundColor: DesignSystemColors.white,
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
                        height: 40,
                        child: Text(
                          'Esqueceu a senha?',
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
                              'assets/images/svg/reset_password/recovery_password_step_1.svg',
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 46),
                      const SizedBox(
                        height: 40,
                        child: Text(
                          'Informe o seu e-mail para receber o código de recuperação de senha.',
                          style: kTextStyleRegisterSubtitleLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Observer(
                        builder: (_) {
                          return _buildEmail();
                        },
                      ),
                      const SizedBox(height: 30),
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

  SingleTextInput _buildEmail() {
    return SingleTextInput(
      keyboardType: TextInputType.emailAddress,
      onChanged: controller.setEmail,
      boxDecoration: WhiteBoxDecorationStyle(
        labelText: 'E-mail',
        errorText: controller.warningEmail,
      ),
    );
  }

  Widget _buildNextButton() {
    return PenhasButton.roundedFilled(
      onPressed: () => controller.nextStepPressed(),
      child: const Text(
        'Próximo',
        style: kTextStyleDefaultFilledButtonLabel,
      ),
    );
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

  void _handleTap(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
