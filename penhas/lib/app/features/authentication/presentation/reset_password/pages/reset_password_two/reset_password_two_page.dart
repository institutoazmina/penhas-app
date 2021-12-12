import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/reset_password/pages/reset_password_two/reset_password_two_controller.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/shared/design_system/button_shape.dart';
import 'package:penhas/app/shared/design_system/colors.dart';
import 'package:penhas/app/shared/design_system/linear_gradient_design_system.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class ResetPasswordTwoPage extends StatefulWidget {
  final String title;
  const ResetPasswordTwoPage({Key? key, this.title = "ResetPasswordTwo"})
      : super(key: key);

  final String title;

  @override
  _ResetPasswordTwoPageState createState() => _ResetPasswordTwoPageState();
}

class _ResetPasswordTwoPageState
    extends ModularState<ResetPasswordTwoPage, ResetPasswordTwoController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageProgressState _currentState = PageProgressState.initial;

  final _maskToken = MaskTextInputFormatter(
    mask: '# # # # # #',
    filter: {'#': RegExp('[0-9]')},
  );

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
    _disposers!.forEach((d) => d());
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
                        height: 40,
                        child: Text(
                          'Verifique seu e-mail',
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
                      const SizedBox(height: 46),
                      const SizedBox(
                        height: 60,
                        child: Text(
                          'Por favor, digite o código de verificação que enviamos para o e-mail de recuperação.',
                          style: kTextStyleRegisterSubtitleLabelStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Observer(
                        builder: (_) {
                          return _buildInputField(
                            labelText: 'Token',
                            keyboardType: TextInputType.number,
                            onChanged: controller.setToken,
                            onError: controller.warrningToken,
                          );
                        },
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

  Widget _buildInputField({
    String? labelText,
    String? hintText,
    required TextInputType keyboardType,
    required Function(String) onChanged,
    String? onError,
  }) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      autofocus: true,
      autocorrect: false,
      inputFormatters: [_maskToken],
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white, fontSize: 48),
    );
  }

  Widget _buildNextButton() {
    return RaisedButton(
      onPressed: () => controller.nextStepPressed(),
      elevation: 0,
      color: DesignSystemColors.ligthPurple,
      shape: kButtonShapeFilled,
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
<<<<<<< HEAD
    }
=======
>>>>>>> Fix code syntax
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }
}
